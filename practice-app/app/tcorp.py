from flask import app

from .views import app, Base, session

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
def change_status(new_status):
    instatus_api_key = os.environ.get("INSTATUS_API_KEY")
    header = {"Authorization": f"Bearer {instatus_api_key}"}

    incidents = get_all_incidents(header)

    if new_status.lower() == "resolved":
        template_id = YES_TEMPLATE
    elif new_status.lower() == "investigating":
        template_id = NO_TEMPLATE
    else:
        return "Invalid status - bad request", 400

    curr_inc = incidents[0]
    curr_inc_id = curr_inc["id"]
    curr_inc_status = curr_inc["status"]

    if new_status.lower() == curr_inc_status.lower():
        print("Status already set to " + curr_inc_status)
        return "Status already set to " + curr_inc_status

    update_incident = requests.post(
        f"{INSTATUS_URL}/v2/{PAGE_ID}/incidents/{curr_inc_id}/incident-updates/{template_id}",
        headers=header,
    )
    print(update_incident.status_code)
    print(update_incident.text)
    print("Status changed to " + new_status)
    return "Status changed to " + new_status
