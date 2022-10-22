# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mach10.Repo.insert!(%Mach10.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

users = [ "Hillary Pugh", "Zachery Hahn", "Kermit Cooke", "Graham Gibbs", "Grant Carson", "Freida Curry", "Seth Oconnor", "Lorraine Powell", "Dario Mahoney", "Rosario Charles", "Warren Holden", "Bonnie Holder", "Tuan Williamson", "Hannah Moyer", "Renee Simpson", "Otto Warren", "Lorena Galvan", "Geraldine Gentry", "Colleen Rosario", "Filiberto Good", "Myrna Huber", "Josh Ray", "Philip Valentine", "Cindy Branch", "Kirk Holloway", "Christopher Sweeney", "Hazel Reid", "Ricardo Evans", "Marjorie Christensen", "Glenna Barnett", "Dick Pitts", "Susanna Ramirez", "Manuel Mcgee", "Augusta Atkins", "Gene Cervantes", "Sonny Black", "Jamal Sparks", "Delmer Bradley", "Camille Choi", "Julianne Myers" ]
user_count = Enum.count(users)

tracks = [ "austria", "canada", "china", "england", "germany", "greece", "italy", "japan", "malaysia", "mexico", "netherlands", "poland", "portugal", "russia", "spain", "thailand", "turkey", "united states" ]
track_count = Enum.count(tracks)

users |> Enum.each& (Mach10.Repo.insert!(%Mach10.Users.User{name: &1}))
tracks |> Enum.each& (Mach10.Repo.insert!(%Mach10.Tracks.Track{name: &1}))

1..150
|> Enum.to_list()
|> Enum.each(fn n ->
  track_id = :random.uniform(track_count)
  user_id = :random.uniform(user_count)

  time = :random.uniform(track_id * 10000) + :random.uniform(10000) + 50000

  Mach10.Repo.insert!(
    %Mach10.Records.Record{user_id: user_id, track_id: track_id, time_ms: time},
    on_conflict: :replace_all,
    conflict_target: [:track_id, :user_id]
  )
end)
