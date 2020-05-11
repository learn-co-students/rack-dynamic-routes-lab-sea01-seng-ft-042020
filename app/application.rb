require "pry"
class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
    
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last 
            item_object = Item.all.find{|item| item.name == item_name}
            if !item_object
                resp.write("Item not found")
                resp.status = 400
            else
                resp.write(item_object.price)
            end
        else
            resp.write("Route not found")
            resp.status = 404
        end
        resp.finish
    end
end