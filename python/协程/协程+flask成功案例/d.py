from flask import Blueprint
from c import a
health_check = Blueprint('health_check_route', __name__, url_prefix='/health_check')


@health_check.route("/a")
def index():
    # perform multiple async requests concurrently
    return a()

    # do something with the results
