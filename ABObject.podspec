Pod::Spec.new do |s|

    s.name              = 'ABObject'
    s.version           = '1.0'
    s.summary           = 'ABUser / ABObject work similar to PFUser / PFObjects from Parse but w/ your own server'
    s.homepage          = 'https://github.com/ashbhat/ABObject'
    s.license      = { :type => 'MIT', :text => 'Copyright 2016. Ash Bhat. This library is distributed under the terms of the MIT/X11.' }
    s.author            = {
        'Ash Bhat' => 'me@ashbhat.com'
    }
    s.source            = {
        :git => 'https://github.com/ashbhat/ABObject.git',
        :tag => s.version.to_s
    }
    s.source_files      = 'ABObjectSuite/*.{m,h}'
    s.requires_arc      = true

end
