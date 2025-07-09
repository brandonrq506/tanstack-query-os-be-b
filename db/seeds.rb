# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#

# Add Genres

[ "Action", "Animation", "Comedy", "Drama", "Horror" ].each do |genre_name|
  Genre.find_or_create_by!(name: genre_name)
end

# Add Movies

[
  {
    title: "The Matrix",
    sinopsis: "A computer hacker learns about the true nature of reality and his role in the war against its controllers.",
    trailer_url: "https://www.youtube.com/watch?v=vKQi3bBA1y8",
    thumbnail_url: "https://i.ytimg.com/vi/vKQi3bBA1y8/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLC4DA-vvYiHapozzZMdVCjyCD-J0g",
    duration_secs: 8160,
    genre_name: "Action",
    is_featured: true,
    published_at: "1999-03-31 00:00:00"
  },
  {
    title: "Inception",
    sinopsis: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
    trailer_url: "https://www.youtube.com/watch?v=YoHD9XEInc0",
    thumbnail_url: "https://i.ytimg.com/vi/YoHD9XEInc0/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCD0XN8JVZYS9LsPd5Nvpq1JJm_Gw",
    duration_secs: 8880,
    genre_name: "Action",
    is_featured: true,
    published_at: "2010-07-16 00:00:00"
  },
  {
    title: "The Godfather",
    sinopsis: "An organized crime dynasty's aging patriarch transfers control of his clandestine empire to his reluctant son.",
    trailer_url: "https://www.youtube.com/watch?v=UaVTIH8mujA",
    thumbnail_url: "https://i.ytimg.com/vi/UaVTIH8mujA/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLByDh3kIc-UXkh5DAZ76IpVwVTyNQ",
    duration_secs: 10800,
    genre_name: "Drama",
    is_featured: true,
    published_at: "1972-03-24 00:00:00"
  },
  {
    title: "The Dark Knight",
    sinopsis: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
    trailer_url: "https://www.youtube.com/watch?v=EXeTwQWrcwY",
    thumbnail_url: "https://i.ytimg.com/vi/EXeTwQWrcwY/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCp-TzBVpJO0lv4GHZhZE4yrHjr2A",
    duration_secs: 9120,
    genre_name: "Action",
    is_featured: true,
    published_at: "2008-07-18 00:00:00"
  },
  {
    title: "Forrest Gump",
    sinopsis: "The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold through the perspective of an Alabama man with an IQ of 75.",
    trailer_url: "https://www.youtube.com/watch?v=bLvqoHBptjg",
    thumbnail_url: "https://i.ytimg.com/vi/bLvqoHBptjg/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLAFl3eSc81XVLsMqUocVDSlgDODCA",
    duration_secs: 8580,
    genre_name: "Drama",
    is_featured: true,
    published_at: "1994-07-06 00:00:00"
  },
  {
    title: "John Wick",
    sinopsis: "An ex-hitman comes out of retirement to track down the gangsters that took everything from him.",
    trailer_url: "https://www.youtube.com/watch?v=bLvqoHBptjg",
    thumbnail_url: "https://i.ytimg.com/vi/C0BMx-qxsP4/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLBwoY2hoFVmaMU-uVsQQEWsARFfUA",
    duration_secs: 6900,
    genre_name: "Action",
    is_featured: true,
    published_at: "2014-10-24 00:00:00"
  },
  {
    title: "John Wick: Chapter 2",
    sinopsis: "John Wick is forced out of retirement by a former associate plotting to seize control of a shadowy international assassins' guild. Bound by a blood oath to aid him, John travels to Rome to confront the world's deadliest killers.",
    trailer_url: "https://www.youtube.com/watch?v=ChpLV9AMqm4",
    thumbnail_url: "https://i.ytimg.com/vi/ChpLV9AMqm4/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLD0mO7mrTw_DbQdXir6DCvmgM5rVA",
    duration_secs: 6900,
    genre_name: "Action",
    is_featured: true,
    published_at: "2017-02-10 00:00:00"
  },
  {
    title: "John Wick: Chapter 3 - Parabellum",
    sinopsis: "In this third installment of the adrenaline-fueled action franchise, super-assassin John Wick (Keanu Reeves) returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin’s guild, the High Table, John Wick is excommunicado, but the world’s most ruthless hit men and women await his every turn.",
    trailer_url: "https://www.youtube.com/watch?v=M7XM597XO94",
    thumbnail_url: "https://i.ytimg.com/vi/M7XM597XO94/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLBX3yHrpn2-VCH4PwNz9g9ZY1q8NQ",
    duration_secs: 7200,
    genre_name: "Action",
    is_featured: true,
    published_at: "2019-05-17 00:00:00"
  },
  {
    title: "John Wick: Chapter 4",
    sinopsis: "John Wick uncovers a path to defeating the High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe, and forces that turn old friends into foes.",
    trailer_url: "https://www.youtube.com/watch?v=qEVUtrk8_B4",
    thumbnail_url: "https://i.ytimg.com/vi/qEVUtrk8_B4/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLAA-AZZ9r0wg8aEOBE3ndO6VkvpVQ",
    duration_secs: 7800,
    genre_name: "Action",
    is_featured: true,
    published_at: "2023-03-24 00:00:00"
  },
  {
    title: 'Django Unchained',
    sinopsis: 'With the help of a German bounty-hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.',
    trailer_url: 'https://www.youtube.com/watch?v=0fUCuvNlOCg',
    thumbnail_url: 'https://i.ytimg.com/vi/0fUCuvNlOCg/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCgkLbTImNCH00y6ZVCKLh-QVCw7g',
    duration_secs: 8880,
    genre_name: 'Drama',
    is_featured: false,
    published_at: '2012-12-25 00:00:00'
  },
  {
    title: 'The Wolf of Wall Street',
    sinopsis: 'A New York stockbroker refuses to cooperate in a large securities fraud case and instead runs his own corrupt brokerage firm.',
    trailer_url: 'https://www.youtube.com/watch?v=Slj4-Sv-YNA',
    thumbnail_url: 'https://i.ytimg.com/vi/Slj4-Sv-YNA/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCFiReRFpgjP8ycPMvXdsU7Qztx3A',
    duration_secs: 10200,
    genre_name: 'Drama',
    is_featured: false,
    published_at: '2013-12-25 00:00:00'
  },
  {
    title: 'Kung Fu Panda',
    sinopsis: 'A clumsy panda becomes an unlikely hero when he is unexpectedly chosen to fulfill an ancient prophecy and save his village from a villainous snow leopard.',
    trailer_url: 'https://www.youtube.com/watch?v=siLm9q4WIjI',
    thumbnail_url: 'https://i.ytimg.com/vi/siLm9q4WIjI/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLD-M4WXubKysFmdrvU8TZXDEE9YIg',
    duration_secs: 6000,
    genre_name: 'Action',
    is_featured: true,
    published_at: '2008-06-06 00:00:00'
  },
  {
    title: 'Kung Fu Panda 2',
    sinopsis: 'Po is unexpectedly reunited with his long-lost biological father and must learn to embrace his true heritage while facing a new villain who threatens to destroy kung fu.',
    trailer_url: 'https://www.youtube.com/watch?v=Sxhm93M3ODY',
    thumbnail_url: 'https://i.ytimg.com/vi/Sxhm93M3ODY/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDulwYAkFNLoQdJvlBHtqByTgdrxg',
    duration_secs: 6000,
    genre_name: 'Action',
    is_featured: true,
    published_at: '2011-05-26 00:00:00'
  },
  {
    title: 'Kung Fu Panda 3',
    sinopsis: 'Po reunites with his biological father and discovers a secret panda village, but must also face a new villain who threatens to destroy kung fu.',
    trailer_url: 'https://www.youtube.com/watch?v=yqN7nHM1YTA',
    thumbnail_url: 'https://i.ytimg.com/vi/yqN7nHM1YTA/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLAvhnuP47sNVtXk_E5O0qr2TGzUnw',
    duration_secs: 6000,
    genre_name: 'Action',
    is_featured: false,
    published_at: '2016-01-29 00:00:00'
  },
  {
    title: "Kung Fu Panda 4",
    sinopsis: "Po must face a new villain who threatens to destroy kung fu, while also dealing with the challenges of being a father to his biological son.",
    trailer_url: "https://www.youtube.com/watch?v=_inKs4eeHiI",
    thumbnail_url: "https://i.ytimg.com/vi/_inKs4eeHiI/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLD4tvQc6FXajYYJIKKAdKlieD9Baw",
    duration_secs: 6000,
    genre_name: "Action",
    is_featured: false,
    published_at: "2024-01-01 00:00:00"
  },
  {
    title: "The Lion King",
    sinopsis: "Lion prince Simba flees his kingdom after the death of his father, Mufasa, but returns as an adult to reclaim his throne.",
    trailer_url: "https://www.youtube.com/watch?v=lFzVJEksoDY",
    thumbnail_url: "https://i.ytimg.com/vi/lFzVJEksoDY/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLA09-zp9o3Szjg-LZiXCsV6gO_KBg",
    duration_secs: 7200,
    genre_name: "Drama",
    is_featured: true,
    published_at: "1994-06-15 00:00:00"
  },
  {
    title: "Toy Story",
    sinopsis: "Woody, a good-hearted cowboy doll who belongs to a young boy named Andy, sees his position as Andy's favorite toy jeopardized when his parents buy him a Buzz Lightyear action figure.",
    trailer_url: "https://www.youtube.com/watch?v=v-PjgYDrg70",
    thumbnail_url: "https://i.ytimg.com/vi/v-PjgYDrg70/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLD0GOmcutXgBo44lBhjfp97NqpDpg",
    duration_secs: 5400,
    genre_name: "Animation",
    is_featured: true,
    published_at: "1995-11-22 00:00:00"
  },
  {
    title: "Toy Story 2",
    sinopsis: "When Woody is stolen by a toy collector, Buzz and his friends set out on a rescue mission to save him.",
    trailer_url: "https://www.youtube.com/watch?v=xNWSGRD5CzU",
    thumbnail_url: "https://i.ytimg.com/vi/xNWSGRD5CzU/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLA9JPzCKh2bZ-K28YxHESgVNyUORg",
    duration_secs: 5400,
    genre_name: "Animation",
    is_featured: false,
    published_at: "1999-11-24 00:00:00"
  },
  {
    title: "Toy Story 3",
    sinopsis: "As Andy prepares to leave for college, Woody, Buzz, and the rest of the toys find themselves in a daycare center where they must fight for their survival.",
    trailer_url: "https://www.youtube.com/watch?v=GQ_qOU6--40",
    thumbnail_url: "https://i.ytimg.com/vi/GQ_qOU6--40/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLB72Xh2HW3XEE3DkvccF2V2GZ8DYg",
    duration_secs: 5400,
    genre_name: "Animation",
    is_featured: true,
    published_at: "2010-06-18 00:00:00"
  },
  {
    title: "Toy Story 4",
    sinopsis: "When a new toy named Forky joins Woody and Buzz's group, they embark on a road trip that reveals how big the world can be for a toy.",
    trailer_url: "https://www.youtube.com/watch?v=wmiIUN-7qhE",
    thumbnail_url: "https://i.ytimg.com/vi/wmiIUN-7qhE/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCKp6tk5aebBPw_l2TQq-WLa06biA",
    duration_secs: 5400,
    genre_name: "Animation",
    is_featured: false,
    published_at: "2019-06-21 00:00:00"
  },
  {
    title: "Wall-E",
    sinopsis: "In a distant future, a small waste-collecting robot inadvertently embarks on a space journey that will ultimately decide the fate of mankind.",
    trailer_url: "https://www.youtube.com/watch?v=CZ1CATNbXg0",
    thumbnail_url: "https://i.ytimg.com/vi/CZ1CATNbXg0/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDU9TnqBJWqYSJy85zx-yE1j2gqiw",
    duration_secs: 5400,
    genre_name: "Animation",
    is_featured: false,
    published_at: "2008-06-27 00:00:00"
  },
{
  title: "Cars",
  sinopsis: "A hotshot race car named Lightning McQueen ends up in a small town and learns valuable life lessons.",
  trailer_url: "https://www.youtube.com/watch?v=W_H7_tDHFE8",
  thumbnail_url: "https://i.ytimg.com/vi/1uq5eJHwio4/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLA3bOxrF4t2RIqD0H2NknFCMDOZCw",
  duration_secs: 5400,
  genre_name: "Animation",
  is_featured: false,
  published_at: "2006-06-09 00:00:00"
},
{
  title: "Cars 2",
  sinopsis: "Lightning McQueen and his friend Mater head overseas to compete in the World Grand Prix, but Mater gets caught up in international espionage.",
  trailer_url: "https://www.youtube.com/watch?v=pTNc0R1FfvY",
  thumbnail_url: "https://i.ytimg.com/vi/pTNc0R1FfvY/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCuNAN-RfETgUGrQ-T6GqMvqHgOPQ",
  duration_secs: 5400,
  genre_name: "Animation",
  is_featured: false,
  published_at: "2011-06-24 00:00:00"
},
{
  title: "Cars 3",
  sinopsis: "Lightning McQueen faces a new generation of racers and must prove that he still has what it takes to compete.",
  trailer_url: "https://www.youtube.com/watch?v=2LeOH9AGJQM",
  thumbnail_url: "https://i.ytimg.com/vi/2LeOH9AGJQM/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLChDYFi-OGqRTJ4W71VByW_qkUXGA",
  duration_secs: 5400,
  genre_name: "Animation",
  is_featured: false,
  published_at: "2017-06-16 00:00:00"
}





].each do |movie_data|
  genre = Genre.find_by(name: movie_data[:genre_name])
  Movie.find_or_create_by!(
    title: movie_data[:title],
    sinopsis: movie_data[:sinopsis],
    trailer_url: movie_data[:trailer_url],
    thumbnail_url: movie_data[:thumbnail_url],
    duration_secs: movie_data[:duration_secs],
    genre: genre,
    is_featured: movie_data[:is_featured],
    published_at: movie_data[:published_at]
  )
end
