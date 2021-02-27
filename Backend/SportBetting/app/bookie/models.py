from app import db


class Bookie (db.Model):
    id = db.Column(db.String(32), primary_key=True)
    adminID = db.Column(db.String(32))
    gameID = db.Column(db.String(32))
    btid = db.Column(db.String(32))
    active = db.Column(db.Boolean)
    datetime = db.Column(db.DateTime)
    outcome = db.Column(db.Integer)


class Outcome(db.Model):
    OutcomeID = db.Column(db.Integer, primary_key=True)
    outcomeIndex = db.Column(db.Integer)
    bookieID = db.Column(db.String(32))
    Outcome = db.Column(db.String(50))
    Odd = db.Column(db.Float)


class BetType(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    betName = db.Column(db.String(32))
    betDesc = db.Column(db.String(100))
