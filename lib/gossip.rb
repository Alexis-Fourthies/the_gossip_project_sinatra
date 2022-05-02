require 'csv'
class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        array_de_gossip = self.all
        return array_de_gossip[id-1] 
    end

    def self.update(id, author, content)
        array_de_gossip = self.all
        array_de_gossip[id-1].author = author
        array_de_gossip[id-1].content = content
        CSV.open("./db/gossip.csv", "wb") do |csv|
            array_de_gossip.each do |gossip|
                csv << [gossip.author, gossip.content]
            end
        end
    end
end
