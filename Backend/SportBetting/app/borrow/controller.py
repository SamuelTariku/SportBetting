
from flask import Flask, Blueprint, jsonify, request
from .models import *

borrow = Blueprint('borrow_control', __name__)


@borrow.route('/borrow', methods=['GET'])
def get_all_borrow():
    borrowAll = Borrow.query.all()

    out = []

    for userBorrow in borrowAll:
        borrow_data = {}
        borrow_data['userid'] = userBorrow.userID
        borrow_data['borrowAmount'] = userBorrow.borrowAmount
        borrow_data['borrowStatus'] = userBorrow.borrowStatus
        borrow_data['borrowOption'] = userBorrow.borrowOption

        out.append(borrow_data)

    return jsonify({'borrow': out})


@borrow.route('/borrow/<userid>', methods=['GET'])
def get_user_borrow(userid):

    borrow = Borrow.query.filter_by(userID=userid).first()

    borrow_data = {}

    borrow_data['userid'] = borrow.userID
    borrow_data['borrowAmount'] = borrow.borrowAmount
    borrow_data['borrowStatus'] = borrow.borrowStatus
    borrow_data['borrowOption'] = borrow.borrowOption

    return jsonify({'borrow': borrow_data})


@borrow.route('/borrow', methods=['POST'])
def create_borrow():
    data = request.get_json()

    borrow = Borrow(
        userID=data['userid'],
        borrowAmount=data['borrowAmount'],
        borrowStatus=data['borrowStatus'],
        borrowOption=data['borrowOption']
    )
    #{'userid' : '2n2134n213n413n241234n12', 'borrowAmount' : 200.00, 'borrowStatus' : true, 'borrowOption' : '1 month'}
    db.session.add(borrow)
    db.session.commit()

    return jsonify({'message': 'borrow has been added to database'})


@borrow.route('/borrow/<userid>', methods=['PUT'])
def update_borrow(userid):
    data = request.get_json()

    borrow = Borrow.query.filter_by(userID=userid).first()

    borrow.borrowOption = data['borrowOption']

    db.session.commit()

    return jsonify({'message': 'borrow'})


@borrow.route('/borrow/<userid>', methods=['DELETE'])
def delete_borrow(userid):
    borrowUser = Borrow.query.filter_by(userID=userid).first()

    if not borrowUser:
        return jsonify({'message': 'borrow user does not exist'})

    db.session.delete(borrowUser)
    db.session.commit()

    return jsonify({'message': 'borrow has been deleted'})

