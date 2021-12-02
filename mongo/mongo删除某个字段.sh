db.env_use_plan.update({
    "duration_time": {
        "$exists": true
    }
}, {
    "$unset": {
        "duration_time":null
    }
}, {
    multi: true
});
db.env_use_plan.update({
    "percent_p": {
        "$exists": true
    }
}, {
    "$unset": {
        "percent_p":null
    }
}, {
    multi: true
});