
require 'openssl'
require 'json'
require 'unirest'

# APIMATIC Helper Files
require 'information_machine_api/api_helper.rb'
require 'information_machine_api/api_exception.rb'
require 'information_machine_api/configuration.rb'
require 'information_machine_api/jsonable.rb'

# Controllers
require 'information_machine_api/controllers/lookup_controller.rb'
require 'information_machine_api/controllers/products_controller.rb'
require 'information_machine_api/controllers/user_management_controller.rb'
require 'information_machine_api/controllers/user_purchases_controller.rb'
require 'information_machine_api/controllers/user_scans_controller.rb'
require 'information_machine_api/controllers/user_stores_controller.rb'

# Models
require 'information_machine_api/models/upload_barcode_request.rb'
require 'information_machine_api/models/upload_receipt_request.rb'
require 'information_machine_api/models/update_user_store_request.rb'
require 'information_machine_api/models/register_user_request.rb'
require 'information_machine_api/models/connect_user_store_request.rb'
