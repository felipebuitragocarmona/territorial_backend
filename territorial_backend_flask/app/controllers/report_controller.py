import requests
from flask import Blueprint, jsonify, request

from app.services.report_service import ReportService


bp = Blueprint("report", __name__)
service = ReportService()


@bp.post("/reports")
def create_report():
    data = request.get_json(silent=True) or {}
    query = data.get("query")

    try:
        payload = service.generate(query)
        return jsonify(payload)
    except ValueError as ex:
        return jsonify({"message": str(ex)}), 400
    except requests.RequestException as ex:
        return jsonify({"message": f"Error calling Gemini: {str(ex)}"}), 502
    except Exception as ex:
        return jsonify({"message": f"Unexpected error: {str(ex)}"}), 500