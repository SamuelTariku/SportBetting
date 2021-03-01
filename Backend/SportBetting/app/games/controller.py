

from flask import Flask, Blueprint, jsonify, request

import datetime
from .models import *
from app.bookie.models import *
import uuid
games = user = Blueprint('games_control', __name__)


@games.route('/games')
def get_all_games():
    games = Game.query.all()

    out = []

    for game in games:
        game_data = {}
        game_data['id'] = game.id
        game_data['team_one'] = game.teamOneName
        game_data['team_two'] = game.teamTwoName
        game_data['datetime'] = game.datetime
        game_data['sport'] = game.sport

        out.append(game_data)

    return jsonify(out)

# Returns JSON to user


@games.route('/games/<game_id>', methods=['GET'])
def get_one_game(game_id):
    game = Game.query.filter_by(id=game_id).first()

    if not game:
        return jsonify({'message': 'no game found'})

    game_data = {}
    game_data['id'] = game.id
    game_data['team_one'] = game.teamOneName
    game_data['team_two'] = game.teamTwoName
    game_data['datetime'] = game.datetime
    game_data['sport'] = game.sport

    return jsonify(game_data)

# Admin controls form request


@games.route('/games', methods=['POST'])
def create_game():
    data = request.get_json()

    # new_bet = Bet(
    #     id=str(uuid.uuid4()),
    #     userID=data['userid'],
    #     bookieID=data['bookieid'],
    #     amount=data['amount'],
    #     outcome=data['outcome']

    # )

    new_game = Game(
        teamOneName=data['team_one'],
        teamTwoName=data['team_two'],
        datetime=data['datetime'],
        sport='Soccer'
    )
    db.session.add(new_game)
    db.session.commit()

    new_game_data = db.session.query(Game).order_by(Game.id.desc()).first()

    bookieIDWL = uuid.uuid4().hex
    bookieIDFS = uuid.uuid4().hex

    winLossBet = Bookie(
        id=bookieIDWL,
        btid=1,
        adminID="",
        gameID=new_game_data.id,
        active=True,
        datetime=data['datetime'],
    )
    db.session.add(winLossBet)

    scoreFirstBet = Bookie(
        id=bookieIDFS,
        btid=2,
        adminID="",
        gameID=new_game_data.id,
        active=True,
        datetime=data['datetime']
    )
    db.session.add(scoreFirstBet)

    winLossOutcomeOne = Outcome(
        outcomeIndex=0,
        bookieID=bookieIDWL,
        Outcome=data['team_one'] + ' wins',
        Odd=data['team_one_odd']
    )
    db.session.add(winLossOutcomeOne)

    winLossOutcomeTwo = Outcome(
        outcomeIndex=1,
        bookieID=bookieIDWL,
        Outcome=data['team_two'] + ' wins',
        Odd=data['team_two_odd']
    )
    db.session.add(winLossOutcomeTwo)
    DrawOutcome = Outcome(
        outcomeIndex=2,
        bookieID=bookieIDWL,
        Outcome='draw',
        Odd=data['draw_odd']
    )
    db.session.add(DrawOutcome)

    scoreFirstOutcomeOne = Outcome(
        outcomeIndex=0,
        bookieID=bookieIDFS,
        Outcome=data['team_one'] + ' wins',
        Odd=data['team_one_score_first_odd']
    )
    db.session.add(scoreFirstOutcomeOne)

    scoreFirstOutcomeTwo = Outcome(
        outcomeIndex=1,
        bookieID=bookieIDFS,
        Outcome=data['team_two'] + ' wins',
        Odd=data['team_two_score_first_odd']
    )

    db.session.add(scoreFirstOutcomeTwo)

    db.session.commit()

    return jsonify({'message': 'new bet created'})


@games.route('/games/<game_id>', methods=['PUT'])
def update_game(game_id):
    data = request.get_json()
    game = Game.query.filter_by(id=game_id).first()

    if not game:
        return jsonify({'message': 'no game found'})

    game.teamOneName = data['team_one']
    game.teamTwoName = data['team_two']
    game.datetime = data['datetime']
    game.sport = data['sport']

    db.session.commit()

    return jsonify({'message': 'bet has been updated'})


@games.route('/games/<game_id>', methods=['DELETE'])
def delete_game(game_id):
    game = Game.query.filter_by(id=game_id).first()
    db.session.delete(game)
    if not game:
        return jsonify({'message': 'no game found'})

    bookieBets = Bookie.query.filter_by(gameID=game_id)
    bookieBetsIDs = []

    for bookieBet in bookieBets:
        bookieBetsIDs.append(bookieBet.id)

        db.session.delete(bookieBet)

    for ids in bookieBetsIDs:
        outcomes = Outcome.query.filter_by(bookieID=ids)

        for outcome in outcomes:
            db.session.delete(outcome)

    db.session.commit()

    return jsonify({'message': 'bet has been deleted'})
