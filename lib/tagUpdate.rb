#!~/.rvm/rubies/ruby-2.4.0/bin/ruby
#require "rubygems"
require "mysql2"

=begin

aAllTags = {"Theme" => ["Abiding", "Acceptance", "Admonition", "Adoption", "Adoration", "Advent", "Affirmation", "Alive", "Alleluia", "Almighty", "Americana", "Angels", "Annunciation", "Anointed", "Apostles", "Appreciation", "Army", "Ascension", "Aspiration", "Assurance", "Atonement", "Authority", "Awesome", "Baby", "Baptism", "Beauty", "Believe", "Benediction", "Bible", "Birth", "Blessing", "Blood", "Boldness", "Bread Of Life", "Breakthrough", "Bride", "Bridegroom", "Calling", "Calvary", "Cantata", "Celebration", "Challenge", "Change", "Character", "Children", "Christ", "Christian Life", "Christmas", "Cleansing", "Comfort", "Commandment", "Commission", "Commitment", "Communion", "Community", "Compassion", "Confession", "Confidence", "Conquering", "Consecration", "Contentment", "Conversion", "Conviction", "Cornerstone", "Courage", "Covenant", "Creation", "Creatures", "Cross", "Crucifixion", "Dance", "Death", "Declaration", "Dedication", "Deliverance", "Desire", "Desperation", "Destiny", "Devotion", "Devotional", "Discipleship", "Dreams", "Dwelling", "Easter", "Empowerment", "Encouragement", "Enticement", "Epiphany", "Eternal", "Eternal Life", "Eucharist", "Evangelism", "Evening", "Everlasting Life", "Exaltation", "Example", "Exhortation", "Expectation", "Faith", "Faithfulness", "Family", "Father", "FathersDay", "Feast", "Fellowship", "Forgiveness", "Foundation", "Freedom", "Friend", "Friendship", "Fruit Of The Spirit", "Fruitfulness", "Fulfillment", "Funeral", "Generosity", "Giving", "Glory", "God As Creator", "God Incarnate", "God's Creation", "God's Love", "God's Word", "Goodness", "Gospel", "Grace", "Gratitude", "Great Commission", "Greatness", "Growth", "Guidance", "Hanukkah", "Harvest", "Haven", "Healing", "Heaven", "Hell", "Help", "Heritage", "High Priest", "His Name", "Holiness", "Holy Fire", "Holy Place", "Holy Spirit", "Home", "Honor", "Hope", "Humility", "Humorous", "Hunger", "Identity", "Image", "Immanuel", "Immerse", "Incarnation", "Indwelling", "Inheritance", "Instruments", "Integrity", "Intercession", "Intervention", "Intimacy", "Invitation", "Israel", "Jerusalem", "Jesus", "Journey", "Joy", "Jubilee", "Judgment", "Justice", "Justification", "Kindness", "King", "Kingdom Of God", "Kingship", "Lamb Of God", "Leadership", "Lent", "Liberty", "Life", "Life Of Jesus", "Light", "Likeness", "Lineage", "Listen", "Living Water", "Living Word", "Longing", "Lordship Of Jesus", "Love", "Lovingkindness", "Lullaby", "Majesty", "Marriage", "Martyrs", "Meditation", "Men", "Mercy", "Messiah", "Millennium", "Miracles", "Missions", "Mother's Day", "Musical", "Nations", "Nature", "Obedience", "Offering", "Old Testament", "Omnipotent", "Omnipresent", "Omniscient", "Overcome", "Palm Sunday", "Passion", "Passover", "Patience", "Patriotic", "Peace", "Pentecost", "Persecution", "Perseverance", "Perspective", "Petition", "Power", "Praise", "Prayer", "Presence", "Processional", "Proclamation", "Prodigal", "Promise", "Prophetic", "Prosperity", "Protection", "Providence", "Provision", "Psalms", "Purity", "Purpose", "Pursue", "Quietness", "Rapture", "Recessional", "Reconciliation", "Redeemer", "Redemption", "Refreshing", "Refuge", "Regret", "Rejoice", "Remembrance", "Renewal", "Repentance", "Rest", "Restoration", "Resurrection", "Reverence", "Revival", "Righteousness", "River", "Rock", "Sabbath School", "Sacrament", "Sacrifice", "Salvation", "Sanctification", "Savior", "Saviour", "Scripture Memory", "Searching", "Seasons", "Second Coming", "Security", "Self Esteem", "Servanthood", "Service", "Shelter", "Shepherd", "Shield", "Sin", "Singing", "Sinless", "Son Of God", "Sorrow", "Sovereignty", "Stewardship", "Strength", "Submission", "Suffering", "Sufficiency", "Supplication", "Surrender", "Sustainer", "Teaching", "Temptation", "Testimony", "Testing", "Thankfulness", "Thanksgiving", "The Church", "Thirst", "Tithes", "Touch", "Transfiguration", "Transformation", "Treasure", "Trials", "Trinity", "Triumph", "Trust", "Truth", "Unchanging", "Uniqueness", "Unity", "Vessel", "Victor", "Victory", "Vine", "Virtue", "Vision", "Voice", "Waiting", "Warfare", "Weather", "Wedding", "Weeping", "Wholeness", "Will", "Wisdom", "Witness", "Women", "Wonder", "Worship", "Worthiness", "Yom Kippur", "Youth", "Zion"], "Tempo" => ["Slow", "Medium", "Fast"]}
begin
   # connect to the MySQL server
    client = Mysql2::Client.new(:host => "localhost", :username => "musicmunky", :password => "Pas9b53!", :database => "myworship_development")

    aAllTags.each do |type, entries|
        entries.each do |tag_name|
#            qString = "INSERT INTO tags (`name`, `tag_type`, `created_at`, `updated_at`) VALUES ('#{Mysql2::Client.escape(tag_name)}', '#{type}', NOW(), NOW())"
#            results = client.query(qString)
#            puts "TYPE IS: #{type} TAGNAME IS #{tag_name}"
        end
    end
rescue => error
    puts "An error occurred"
    puts "Error code:    #{error.backtrace}"
    puts "Error message: #{error.message}"
ensure
    puts "Script ending now..."
end
=end


#puts "tags are #{aAllTags}"