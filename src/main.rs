use axum::{routing::get, serve, Router};
use controllers::{health, jungle};
use tokio::net::TcpListener;
use tower_http::services::fs::ServeDir;
use tracing::{debug, Level};

mod controllers;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_max_level(Level::DEBUG)
        .init();

    let app = Router::new()
        .nest_service("/assets", ServeDir::new("assets")) // serve the file in the "assets" directory under `/assets`
        .route("/health", get(health))
        .route("/jungle", get(jungle));

    let listener = TcpListener::bind("0.0.0.0:5000").await.unwrap();

    debug!("listening on {}", listener.local_addr().unwrap());

    serve(listener, app).await.unwrap();
}
