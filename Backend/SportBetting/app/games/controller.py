

from flask import Flask, Blueprint, jsonify

from .models import *

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
        game_data['datatime'] = game.datetime
        game_data['sport'] = game.sport

        out.append(game_data)

    return jsonify({'games': out})

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
    return ''


@games.route('/games/<game_id>', methods=['PUT'])
def update_game(game_id):
    return ''


@games.route('/games/<game_id>', methods=['DELETE'])
def delete_game(game_id):
    return ''
