use axum::response::Json;
use reqwest::get;
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Debug)]
pub struct Step {
    name: String,
    status: String,
}

pub async fn health() -> &'static str {
    "OK"
}

pub async fn jungle() -> Json<Vec<Step>> {
    let steps = get("http://ai.private.dev.cs2024.one/jungle")
        .await
        .unwrap()
        .json::<Vec<Step>>()
        .await
        .unwrap();

    return Json(steps);
}
