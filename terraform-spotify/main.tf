terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.spotify_api_key
}

data "spotify_search_track" "by_artist_and_album" {
  artist = "The 502s"
  album = "Could It Get Better Than This"
}

data "spotify_search_track" "by_artist_and_album2" {
  artist = "Kodaline"
  album = "Politics of Living"
}

data "spotify_search_track" "by_name_and_artist" {
  artist = "Kygo"
  name = "Stargazing (Orchestral Version)"
}

data "spotify_search_track" "by_name" {
  name  = "World At Our Feet"
}

data "spotify_search_track" "by_name1" {
  name = "Drums & Drops"
}

data "spotify_search_track" "by_name2" {
  name = "Year 3000"
}

data "spotify_track" "by_id" {
  spotify_id = "1A8s182NfOT6dOXjPsWfTn"
}

data "spotify_track" "ajr_by_url" {
  url = "https://open.spotify.com/track/2dgFqylK6gyILa4HY65u0y?si=3348c09cbae449a3"
}

data "spotify_track" "rf_by_url" {
  url = "https://open.spotify.com/track/5YbeJyTQkdSAWe1Ie4sLAl?si=86c83a9e8a0f4c4b"
}

resource "spotify_playlist" "playlist" {
  name        = "Hannah's Terraform Playlist"
  description = "This playlist was created by Terraform"
  public      = true
  
  tracks = [
    //spotify search
    data.spotify_search_track.by_artist_and_album.tracks[0].id, 
    data.spotify_search_track.by_name_and_artist.tracks[0].id, 
    data.spotify_search_track.by_artist_and_album.tracks[1].id,
    data.spotify_search_track.by_name.tracks[0].id,

    data.spotify_search_track.by_artist_and_album2.tracks[1].id,
    data.spotify_search_track.by_name1.tracks[0].id,
    data.spotify_search_track.by_name2.tracks[0].id,

    //track specific via id or URL 
    data.spotify_track.ajr_by_url.id,
    data.spotify_track.by_id.id,
    data.spotify_track.rf_by_url.id,
  ]
}
