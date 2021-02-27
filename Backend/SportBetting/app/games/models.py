from app import db


class Game (db.Model):
    id = db.Column(db.Integer, primary_key=True)
    teamOneName = db.Column(db.String(50))
    teamTwoName = db.Column(db.String(50))
    datetime = db.Column(db.String)
    sport = db.Column(db.String)
