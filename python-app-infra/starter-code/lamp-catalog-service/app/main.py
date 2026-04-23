from __future__ import annotations

import json
from pathlib import Path
from typing import Any

from fastapi import FastAPI, HTTPException
from fastapi.responses import PlainTextResponse
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest

app = FastAPI(title="lamp-catalog-service", version="0.1.0")

DATA_PATH = Path(__file__).resolve().parent.parent / "data" / "lamps.json"

REQUEST_COUNT = Counter("lamp_catalog_requests_total", "Total catalog API requests", ["endpoint"])
REQUEST_LATENCY = Histogram("lamp_catalog_request_duration_seconds", "Request latency", ["endpoint"])


def load_catalog() -> list[dict[str, Any]]:
    if not DATA_PATH.exists():
        raise FileNotFoundError(f"Catalog data file not found: {DATA_PATH}")

    with DATA_PATH.open("r", encoding="utf-8") as f:
        data = json.load(f)

    if not isinstance(data, list):
        raise ValueError("Catalog data must be a list")

    return data


@app.get("/healthz")
def healthz() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/api/v1/lamps")
def list_lamps() -> dict[str, Any]:
    endpoint = "/api/v1/lamps"
    REQUEST_COUNT.labels(endpoint=endpoint).inc()

    with REQUEST_LATENCY.labels(endpoint=endpoint).time():
        lamps = load_catalog()

    return {"count": len(lamps), "items": lamps}


@app.get("/api/v1/lamps/{lamp_id}")
def get_lamp(lamp_id: str) -> dict[str, Any]:
    endpoint = "/api/v1/lamps/{lamp_id}"
    REQUEST_COUNT.labels(endpoint=endpoint).inc()

    with REQUEST_LATENCY.labels(endpoint=endpoint).time():
        lamps = load_catalog()
        for lamp in lamps:
            if lamp.get("id") == lamp_id:
                return lamp

    raise HTTPException(status_code=404, detail=f"Lamp '{lamp_id}' not found")


@app.get("/metrics")
def metrics() -> PlainTextResponse:
    return PlainTextResponse(generate_latest().decode("utf-8"), media_type=CONTENT_TYPE_LATEST)
