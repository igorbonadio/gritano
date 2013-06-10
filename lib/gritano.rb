root_path = File.expand_path(File.dirname(__FILE__))

require "gritano-core"
require 'terminal-table'

require File.join(root_path, 'gritano/thor')
require File.join(root_path, 'gritano/renderer')
require File.join(root_path, 'gritano/helpers')
require File.join(root_path, 'gritano/console')
require File.join(root_path, 'gritano/core/user')