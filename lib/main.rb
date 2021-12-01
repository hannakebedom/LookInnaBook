#!/usr/bin/ruby
require_relative 'model'

def main
    db = Model.new
    db.display_instructors
end

main