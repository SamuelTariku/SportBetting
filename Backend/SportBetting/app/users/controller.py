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
            data = jwt.decode(token, current_app.config['SECRET_KEY'])
            current_user = User.query.filter_by(
                public_id=data['public_id']).first()
        except:
            return jsonify({'message': 'token is invalid'}), 401

        return f(current_user, **args, **kwargs)
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
        email=data['email'],
        phoneNo=data['phone_number']
    )

    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'New user created'})


@user.route('/user/<public_id>', methods=['GET'])
@token_required
def get_one_user(current_user, public_id):
    user = User.query.filter_by(public_id=public_id).first()

    if not user:
        return jsonify({'message': 'no user found'})

    user_data = {}
    user_data['public_id'] = user.public_id
    user_data['username'] = user.username
    user_data['password'] = user.password
    user_data['email'] = user.email
    user_data['phone_number'] = user.phoneNo

    return jsonify({'user': user_data})


@user.route('/user/<public_id>', methods=['PUT'])
@token_required
def update_user(current_user, public_id):

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


@user.route('/user/<public_id>', methods=['DELETE'])
@token_required
def delete_user(current_user, public_id):
    user = User.query.filter_by(public_id=public_id).first()

    if not user:
        return jsonify({'message': 'no user found'})

    db.session.delete(user)
    db.session.commit()

    return jsonify({'message': 'user has been deleted'})


@user.route('/user/login')
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

        print(token)

        return jsonify({'token': token})

    return make_response('Could not verify', 401, {'WWW-Authenticate': 'Basic realm="Login required"'})
