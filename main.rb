load 'lib/log.rb'
log = Log.new('lib/games.log')
log.read_log
log.emit
