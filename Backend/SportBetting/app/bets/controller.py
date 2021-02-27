

from flask import Flask, Blueprint, request, jsonify

from .models import *

import datetime
import uuid

bets = user = Blueprint('bets_control', __name__)


@bets.route('/bets')
def get_all_bets():
    bets = Bet.query.all()

    out = []

    for bet in bets:
        bet_data = {}
        bet_data['id'] = bet.id
        bet_data['userid'] = bet.userID
        bet_data['bookieid'] = bet.bookieID
        bet_data['amount'] = bet.amount
        bet_data['outcome'] = bet.outcome
        out.append(bet_data)
    print(out)

    return jsonify({'bets': out})


@bets.route('/bets/<bet_id>', methods=['GET'])
def get_one_bet(bet_id):
    bet = Bet.query.filter_by(id=bet_id).first()

    if not bet:
        return jsonify({'message': 'no bet found'})

    bet_data = {}
    bet_data['id'] = bet.id
    bet_data['userid'] = bet.userID
    bet_data['bookieid'] = bet.bookieID
    bet_data['amount'] = bet.amount
    bet_data['outcome'] = bet.outcome

    return jsonify({'bet': bet_data})


@bets.route('/bets/user/<user_id>', methods=['GET'])
def get_by_user(user_id):
    bets = Bet.query.filter_by(userID=user_id)

    if not bets:
        return jsonify({'message': 'no bet found'})

    out = []

    for bet in bets:
        bet_data = {}
        bet_data['id'] = bet.id
        bet_data['userid'] = bet.userID
        bet_data['bookieid'] = bet.bookieID
        bet_data['amount'] = bet.amount
        bet_data['outcome'] = bet.outcome

        out.append(bet_data)

    return jsonify({'bets': out})


@bets.route('/bets', methods=['POST'])
def create_bet():
    data = request.get_json()

    new_bet = Bet(
        id=str(uuid.uuid4()),
        userID=data['userid'],
        bookieID=data['bookieid'],
        amount=data['amount'],
        outcome=data['outcome']

    )

    db.session.add(new_bet)
    db.session.commit()

    return jsonify({'message': 'new bet created'})


@bets.route('/bets/<bets_id>', methods=['PUT'])
def update_bet(bet_id):
    data = request.get_json()

    bet = Bet.query.filter_by(id=bet_id)

    if not bet:
        return jsonify({'message': 'no bet found'})

    bet.amount = data['amount']
    bet.outcome = data['outcome']

    db.session.commit()

    return jsonify({'message': 'bet has been updated'})


@bets.route('/bets/<bets_id>', methods=['DELETE'])
def delete_bet(bet_id):
    bet = Bet.query.filter_by(id=bet_id).first()

    if not bet:
        return jsonify({'message': 'no bet found'})

    if bet.datetime > datetime.now():
        return jsonify({'message': 'time has passed'})

    db.session.delete(bet)
    db.session.commit()

    return jsonify({'message': 'bet has been deleted'})
