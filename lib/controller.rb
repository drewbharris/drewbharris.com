path = File.expand_path(File.dirname(__FILE__))

require 'rack'
require "#{path}/template"

module Controller
    URL_MAP = {
        '/' => proc {|env| Controller.index(env)},
        '/projects' => proc {|env| Controller.projects(env)},
        '/about' => proc {|env| Controller.about(env)},
    }

    def self.index(env)
        body = Template.render(:index, {})
        return [200, {'Content-Type' => 'text/html'}, [body]]
    end

    def self.about(env)
        body = Template.render(:about, {})
        return [200, {'Content-Type' => 'text/html'}, [body]]
    end

    def self.projects(env)
        request = Rack::Request.new(env)

        if request.path.match(/^\/projects\/(.*)/) && request.path.match(/^\/projects\/(.*)/)[1] != ""
            project = request.path.match(/^\/projects\/(.*)/)[1]
            body = Template.render(:project, {
                'project' => project,
                'content' => Template.render(project.to_sym, {})
            })
            return [200, {'Content-Type' => 'text/html'}, [body]]
        else
            body = Template.render(:projects, {
                'sharedtapes_description' => 'real-time playlist collaboration (node.js, backbone.js, socket.io)',
                'multi_description' => 'multi-channel audio performance (node.js, html5 web audio api)',
                'livectl_description' => 'peer-to-peer network midi patching (node.js)',
                'vila_description' => 'visual live music performance companion (iOS, C++)',
                'lightarray_description' => 'visual live music performance companion (arduino, hardware)',
                'photogallery_description' => 'photo gallery with extras (python, flask)',
                'journal_description' => 'community text/photo/link blog network (python, django)'
            })
            return [200, {'Content-Type' => 'text/html'}, [body]]
        end
    end

    def self.not_found
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end

end



