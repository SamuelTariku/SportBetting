

from flask import Flask, Blueprint, jsonify

from .models import *

bookie = Blueprint('bookie_control', __name__)


@bookie.route('/bookie')
def get_all_bookie_bets():
    bookieBets = Bookie.query.all()

    out = []

    for bet in bookieBets:

        bt = BetType.query.filter_by(id=bet.btid).first()

        bettype_data = {}
        bettype_data['id'] = bt.id
        bettype_data['bet_name'] = bt.betName
        bettype_data['bet_desc'] = bt.betDesc

        outcomes = Outcome.query.filter_by(bookieID=bet.id)

        outcomes_data = []

        for outcome in outcomes:
            outcome_data = {}
            outcome_data['outcome'] = outcome.Outcome
            outcome_data['odd'] = outcome.Odd
            outcome_data['index'] = outcome.outcomeIndex
            outcomes_data.append(outcome_data)

        bet_data = {}
        bet_data['id'] = bet.id
        bet_data['game_id'] = bet.gameID
        bet_data['btid'] = bet.btid
        bet_data['bettype'] = bettype_data
        bet_data['datetime'] = bet.datetime
        bet_data['outcomes'] = outcomes_data
        bet_data['outcome'] = bet.outcome
        if(bet.active):
            out.append(bet_data)

    return jsonify(out)

# Returns JSON to user


@bookie.route('/bookie/<bookie_id>', methods=['GET'])
def get_bookie(bookie_id):
    bookieBet = Bookie.query.filter_by(id=bookie_id).first()
    if not bookieBet:
        return jsonify({'message': 'no game found'})

    bt = BetType.query.filter_by(id=bookieBet.btid).first()

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

    return jsonify(bookie_data)


@bookie.route('/bookie/game/<game_id>', methods=['GET'])
def get_bookie_game(game_id):
    bookieBet = Bookie.query.filter_by(gameID=game_id).first()
    if not bookieBet:
        return jsonify({'message': 'no game found'})

    bt = BetType.query.filter_by(id=bookieBet.btid).first()

    outcomes = Outcome.query.filter_by(bookieID=bookieBet.id)

    print(outcomes, bookieBet.id)

    bettype_data = {}
    bettype_data['id'] = bt.id
    bettype_data['bet_name'] = bt.betName
    bettype_data['bet_desc'] = bt.betDesc

    outcomes_data = []

    for outcome in outcomes:
        outcome_data = {}
        outcome_data['outcome'] = outcome.Outcome
        outcome_data['odd'] = outcome.Odd
        outcome_data['index'] = outcome.outcomeIndex
        outcomes_data.append(outcome_data)

    bookie_data = {}
    bookie_data['id'] = bookieBet.id
    bookie_data['game_id'] = bookieBet.gameID
    bookie_data['bettype'] = bettype_data
    bookie_data['active'] = bookieBet.active
    bookie_data['datetime'] = bookieBet.datetime
    bookie_data['outcomes'] = outcomes_data
    bookie_data['outcome'] = bookieBet.outcome

    return jsonify(bookie_data)


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
