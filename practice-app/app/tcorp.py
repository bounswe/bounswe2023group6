from flask import app, render_template, jsonify

from .views import app
from flasgger import swag_from


import json
import os
import requests

PAGE_ID = "clhe4m8r51385441dmzneperc58"
NO_TEMPLATE = "clhe627g51571411dmzj73v5tyk"
YES_TEMPLATE = "clhe63sdy1582381dmzszbs884p"

COMP1 = "clhe4m8xh1385721dmzdlxxrlbd"
COMP2 = "clhe4m8xw1385821dmz8e0wtzr1"

INSTATUS_URL = "https://api.instatus.com"


def get_all_incidents(header):
    all_incidents = requests.get(
        f"{INSTATUS_URL}/v1/{PAGE_ID}/incidents", headers=header
    ).json()
    return all_incidents


@app.route("/change_status/<new_status>", methods=["POST"])
@swag_from({
    'tags': ['Change Status'],
    'parameters': [
        {
            'name': 'new_status',
            'description': 'New status to change to. This can be either "resolved" or "investigating".',
            'in': 'path',
            'type': 'string',
            'required': 'true',
        }
    ],
    'responses': {
        '200': {
            'description': 'Status changed successfully or status was already in the desired state. Returns a message detailing the result.',
            'examples': {
                'application/json': {
                    "status": 200,
                    "message": "Status changed - resolved"
                }
            }
        },
        '404': {
            'description': 'Invalid status provided. Returns a message indicating the status was not found.',
            'examples': {
                'application/json': {
                    "status": 404,
                    "message": "Page not found"
                }
            }
        }
    }
})
def change_status(new_status):
    instatus_api_key = os.environ.get("INSTATUS_API_KEY")
    header = {"Authorization": f"Bearer {instatus_api_key}"}

    incidents = get_all_incidents(header)

    if new_status.lower() == "resolved":
        template_id = YES_TEMPLATE
    elif new_status.lower() == "investigating":
        template_id = NO_TEMPLATE
    else:
        return jsonify({"status": 404, "message": "Page not found"})

    curr_inc = incidents[0]
    curr_inc_id = curr_inc["id"]
    curr_inc_status = curr_inc["status"]

    if new_status.lower() == curr_inc_status.lower():
        return jsonify(
            {"status": 200, "message": "Status " + curr_inc_status + " already"}
        )

    update_incident = requests.post(
        f"{INSTATUS_URL}/v2/{PAGE_ID}/incidents/{curr_inc_id}/incident-updates/{template_id}",
        headers=header,
    )
    if update_incident.status_code != 200:
        # returning 200 to show error of the external api successfully on the front end
        return jsonify(
            {
                "status": 200,
                "message": f"Something went wrong while updating the status: {update_incident.text}",
            }
        )

    return jsonify({"status": 200, "message": "Status changed - " + new_status})


@app.route("/get_current_status", methods=["GET"])
@swag_from({
    'tags': ['Change Status'],
    'responses': {
        '200': {
            'description': 'Current status of the page. Can be either "investigating" or "resolved"',
            'examples': {
                'application/json': {
                    "status": 200,
                    "message": "investigating"
                }
            }
        }
    }
})
def get_current_status():
    instatus_api_key = os.environ.get("INSTATUS_API_KEY")
    header = {"Authorization": f"Bearer {instatus_api_key}"}

    incidents = get_all_incidents(header)[0]
    curr_status = incidents["status"]

    return jsonify({"status": 200, "message": curr_status})


@app.route("/status_page")
@swag_from({
    'tags': ['Change Status'],
    'responses': {
        '200': {
            'description': 'Renders the status page with the current status.',
        }
    }
})
def get_status_page():
    curr_status_response = get_current_status()
    curr_status_dict = json.loads(curr_status_response.response[0])
    return render_template("status_page.html", curr_status=curr_status_dict["message"])
