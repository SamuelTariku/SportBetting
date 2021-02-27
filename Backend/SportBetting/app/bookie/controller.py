

from flask import Flask, Blueprint, jsonify

from .models import *

bookie = Blueprint('bookie_control', __name__)


@bookie.route('/bookie')
def get_all_bookie_bets():
    bookieBets = Bookie.query.all()

    out = []

    for bet in bookieBets:
        bet_data = {}
        bet_data['id'] = bet.id
        bet_data['team_one'] = bet.teamOneName
        bet_data['team_two'] = bet.teamTwoName
        bet_data['datatime'] = bet.datetime
        bet_data['sport'] = bet.sport

        out.append(bet_data)

    return jsonify({'bookie': out})

# Returns JSON to user


@bookie.route('/bookie/<bookie_id>', methods=['GET'])
def get_bookie(bookie_id):
    bookieBet = Bookie.query.filter_by(id=bookie_id).first()
    if not bookieBet:
        return jsonify({'message': 'no game found'})

    bt = BetType.query.filter_by(id=bookieBet.BetType).first()

    bettype_data = {}
    bettype_data['id'] = bt.id
    bettype_data['bet_name'] = bt.betName
    bettype_data['bet_desc'] = bt.betDesc

    bookie_data = {}
    bookie_data['id'] = bookieBet.id
    bookie_data['game_id'] = bookieBet.gameID
    bookie_data['bettype'] = bettype_data
    bookie_data['active'] = bookieBet.active
    bookie_data['datetime'] = bookieBet.datetime
    bookie_data['outcome'] = bookieBet.outcome

    return jsonify({'bookie': bookie_data})


# Admin controls form request
@bookie.route('/bookie', methods=['POST'])
def create_bookie_bet():

    return ''


# Admin side
@bookie.route('/bookie/<bookieID>', methods=['PUT'])
def update_bookie_bet(bookieID):
    return ''


@bookie.route('/bookie/<bookieID>', methods=['DELETE'])
def delete_bookie_bet(bookieID):
    return ''
