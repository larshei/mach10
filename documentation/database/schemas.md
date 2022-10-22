# Database Schemas

| Mach10 tracks Records of Users for Tracks.


Mach10 tracks
```
┌─────────────────────────┐
│ Record                  │
├─────────────┬───────────┤
│ track_id    │ id:Track  │
│ user_id     │ id:User   │
│ time_ms     │ timestamp │
│ created_at  │ datetime  │
└─────────────┴───────────┘
```
`mix phx.gen.json Records Record records track_id:references:tracks user_id:references:users time_ms:integer`

of
```
┌─────────────────────────────┐
│ User                        │
├──────────────┬──────────────┤
│ id           │ id           │
│ name         │ varchar(64)  │
│ image_url    │ varchar(255) │
│ created_at   │ datetime     │
│ changed_at   │ datetime     │
│ deleted_at   │ datetime     │
│ last_seen_at │ datetime     │
└──────────────┴──────────────┘
```
`mix phx.gen.json Users User users name image_url deleted_at:utc_datetime last_seen_at:utc_datetime`

for
```
┌───────────────────────────┐
│ Track                     │
├────────────┬──────────────┤
│ id         │ id           │
│ name       │ varchar(64)  │
│ image_url  │ varchar(255) │
│ created_at │ datetime     │
│ changed_at │ datetime     │
│ deleted_at │ datetime     │
└────────────┴──────────────┘
```
`mix phx.gen.json Tracks Track tracks name image_url deleted_at:utc_datetime`