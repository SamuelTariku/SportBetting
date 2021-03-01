import uuid
import jwt
import datetime

from app import db

from flask import Flask, Blueprint, request, jsonify, make_response, current_app
from werkzeug.security import generate_password_hash, check_password_hash
from .models import *
from functools import wraps
from flask_login import login_required

user = Blueprint('user_control', __name__)


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'x-access-token' in request.headers:

            token = request.headers['x-access-token']

        if not token:
            return jsonify({'message': 'Token is missing!'}), 401

        try:
            # current_app.config['SECRET_KEY']
            data = jwt.decode(
                token, current_app.config['SECRET_KEY'], algorithms=["HS256"])
            print(data)
            print("test")
            current_user = User.query.filter_by(
                public_id=data['public_id']).first()
        except Exception as e:
            print(e)
            return jsonify({'message': 'token is invalid'}), 401
        print(args, kwargs)
        return f(current_user, **kwargs)
    return decorated


@user.route('/user', methods=['GET'])
@login_required
def get_all_users():
    users = User.query.all()

    out = []

    for user in users:
        user_data = {}
        user_data['public_id'] = user.public_id
        user_data['username'] = user.username
        user_data['password'] = user.password
        user_data['email'] = user.email
        user_data['phone_number'] = user.phoneNo
        user_data['balance'] = user.balance
        out.append(user_data)

    return jsonify({'users': out})


@user.route('/user', methods=['POST'])
def create_user():
    data = request.get_json()

    hashed_password = generate_password_hash(data['password'], method='sha256')

    new_user = User(
        public_id=str(uuid.uuid4()),
        username=data['username'],
        password=hashed_password,
        balance=0.0,
        email=None,
        phoneNo=None
    )

    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'New user created'}), 201


@user.route('/user/<public_id>', methods=['GET'])
@token_required
def get_one_user(current_user, public_id):
    print(public_id)
    user = User.query.filter_by(public_id=public_id).first()

    if not user:

        return jsonify({'message': 'no user found'})

    user_data = {}
    user_data['public_id'] = user.public_id
    user_data['username'] = user.username
    user_data['password'] = user.password
    user_data['email'] = user.email
    user_data['phone_number'] = user.phoneNo
    user_data['balance'] = user.balance

    return jsonify(user_data)


@user.route('/user/<public_id>', methods=['PUT'])
def update_user(public_id):

    data = request.get_json()

    user = User.query.filter_by(public_id=public_id).first()

    if not user:
        return jsonify({'message': 'no user found'})

    hashed_password = generate_password_hash(data['password'], method='sha256')
    user.username = data['username']
    user.passowrd = hashed_password
    user.email = data['email']
    user.phoneNo = data['phone_number']

    db.session.commit()

    return jsonify({'message': 'user has been updated'})


@user.route('/user/<public_id>', methods=['PUT'])
def change_balance(public_id):
    data = request.get_json()

    user = User.query.filter_by(public_id=public_id).first()

    if not user:
        return jsonify({'message': 'no user found'})

    user.balance = data['balance']

    db.session.commit()

    return jsonify({'message': 'user has been updated'})


@user.route('/user/<public_id>', methods=['DELETE'])
def delete_user(current_user, public_id):
    user = User.query.filter_by(public_id=public_id).first()

    if not user:
        return jsonify({'message': 'no user found'})

    db.session.delete(user)
    db.session.commit()

    return jsonify({'message': 'user has been deleted'})


@user.route('/user/login', methods=['POST'])
def login_api():
    data = request.get_json()

    user = User.query.filter_by(username=data['username']).first()

    if(not user):
        return jsonify({'message': 'username not found', 'token': ''}), 200

    if check_password_hash(user.password, data['password']):
        token = jwt.encode({'public_id': user.public_id, 'exp': datetime.datetime.utcnow(
        ) + datetime.timedelta(minutes=30)}, current_app.config['SECRET_KEY'])

        # print(token)

        return jsonify({'token': token}), 201

    return jsonify({'token': '', 'message': 'incorrect username or password'}), 401


@user.route('/user/login', methods=['GET'])
def login():
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response('Could not verify', 401, {'WWW-Authenticate': 'Basic realm="Login required"'})

    user = User.query.filter_by(username=auth.username).first()

    if not user:
        return make_response('Could not verify', 401, {'WWW-Authenticate': 'Basic realm="Login required"'})

    if check_password_hash(user.password, auth.password):
        token = jwt.encode({'public_id': user.public_id, 'exp': datetime.datetime.utcnow(
        ) + datetime.timedelta(minutes=30)}, current_app.config['SECRET_KEY'])

        # print(token)
        return jsonify({'token': token})

    return make_response('Could not verify', 401, {'WWW-Authenticate': 'Basic realm="Login required"'})
