#-----------------------------------------------------------------------------
# Compatible: SketchUp 7 (PC)
#             (other versions untested)
#-----------------------------------------------------------------------------
#
# CHANGELOG
# 1.0.0 - 30.08.2010
#		 * Initial release.
#
#-----------------------------------------------------------------------------
#
# Thomas Thomassen
# thomas[at]thomthom[dot]net
#
#-----------------------------------------------------------------------------

=begin


http://www.cgafaq.info/wiki/Evenly_distributed_points_on_sphere

http://www.ams.org/samplings/feature-column/fcarc-irrational1
http://www.ams.org/samplings/feature-column/fcarc-irrational5


cls
model = Sketchup.active_model

model.entities.clear!

origin = Geom::Point3d.new( 10, 10, 10 )

n = 64
node = Array.new( n )
s = 3.6 / Math.sqrt(n)
dz = 2.0/n
long = 0
z = 1 - dz/2
(0...n).each { |k|
r = Math.sqrt( 1-z*z )
node[k] = [ Math.cos(long)*r, Math.sin(long)*r, z ]
z = z - dz
long = long + s/r
}

node.each { |pt|
model.entities.add_cpoint( pt )
}






cls
model = Sketchup.active_model

model.entities.clear!

origin = Geom::Point3d.new( 10, 10, 10 )

n = 64
node = Array.new( n )
dlong = Math::PI * (3-Math.sqrt(5))
dz = 2.0/n
long = 0
z = 1 - dz/2
(0...n).each { |k|
  r = Math.sqrt( 1-z*z )
  node[k] = [ Math.cos(long)*r, Math.sin(long)*r, z ]
  z = z - dz
  long = long + dlong
}

node.each { |pt|
  model.entities.add_cpoint( pt )
}

=end


require 'sketchup.rb'
require 'TT_Lib2/core.rb'

TT::Lib.compatible?('2.3.0', 'TT Guide Tools')

#-----------------------------------------------------------------------------

module TT::Plugins::GeoSphere  
  
  ### CONSTANTS ### --------------------------------------------------------
  
  VERSION = '1.0.0'
  
  
  ### MENU & TOOLBARS ### --------------------------------------------------
  
  unless file_loaded?( File.basename(__FILE__) )
    m = TT.menu('Draw')
    m.add_item('Geosphere') { self.draw_geospehere }
  end
  
  
  ### MAIN SCRIPT ### ------------------------------------------------------
  
  # http://www.math.niu.edu/~rusin/known-math/96/repulsion
  
  
  def self.draw_geospehere
    model = Sketchup.active_model
    pts = TT::Geom3d.spiral_sphere( 64 )
    TT::Model.start_operation('Spiral Sphere')
    
    #model.entities.clear!
    
    v = Geom::Vector3d.new(1,1,1)
    v.length = 0.1
    
    i = 0
    for pt in pts
      model.entities.add_text( i.to_s, pt, v )
      model.entities.add_cpoint( pt )
      i += 1
    end
    model.entities.add_curve( pts )
    
    model.commit_operation
  end
  
  
  ### DEBUG ### ------------------------------------------------------------
  
  def self.reload
    load __FILE__
  end
  
end # module

#-----------------------------------------------------------------------------
file_loaded( File.basename(__FILE__) )
#-----------------------------------------------------------------------------