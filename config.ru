require 'rack'
#\ -w -p 8765
 
# The line above containg options
# passed to rackup utility.
# (Ruby warnings enabled, request port 8765)
 
# Middlewares below will be added
# to stack of middlewares
use Rack::Reloader, 0
use Rack::ContentLength
 
# app can be Class, Instance, or block

class SystemInformation 
   def call(env)
       @req = Rack::Request.new(env)
       @res = Rack::Response.new()
       @res.status = 200  
       @res['Content-Type'] = 'text/plain'
       @res.body = handle(@req.env['PATH_INFO'])
       @res.finish
   end
   def handle(location)
	result = []
	case location
		when '/memory'
			result << "Memory:"+`free -m`

                when '/disc'
                        result << `df -h`
                when '/'
                        result << "User info:"+`uname -a && uptime`
		when "/help"
             		result << '"/" - used memory and disk space
			+"/memory" - total memory size
			+"/disc" - disk capacity
			+"/help" - shows this help page'
                else
                        result << "nothing here"
                end
               	result
	end
end


run SystemInformation.new
 

