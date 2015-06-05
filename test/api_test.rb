require 'information_machine_api'
require './api_test_exception.rb'

def wait_for_scrape_to_finish user_stores_controller, user_identifier, store_id

    # try to see if the users credentials are valid
    for i in 0..60
        connected_store = user_stores_controller.user_stores_get_single_store(user_identifier, store_id);

        if (connected_store != nil and
            connected_store["result"]["scrape_status"] == "Done")
            return true;
        end

        sleep 3
    end

    return false;
end

def check_store_validity user_stores_controller, user_identifier, store_id

    # try to see if the users credentials are valid
    for i in 0..15
        connected_store = user_stores_controller.user_stores_get_single_store(user_identifier, store_id);

        if (connected_store != nil)
            if(connected_store["result"]["credentials_status"] == "Verified")
                return true;
            elsif(connected_store["result"]["credentials_status"] == "Invalid")
                return false;
            end
        end

        sleep 3
    end

    return false;
end

def user_management_controller_test email, user_management_controller, user_id

    register_user_request = InformationMachineApi::RegisterUserRequest.new()
    register_user_request.email = email
    register_user_request.user_id = user_id
    register_user_request.zip = "21000"

    user = user_management_controller.user_management_create_user(register_user_request.to_json);

    if (user["result"]["email"] != email or user["result"]["user_id"] != user_id)
        raise InformationMachineApi::APITestException.new "Error: create user"
    end

    all_users = user_management_controller.user_management_get_all_users();

    if (all_users["result"].length == 0)
        raise InformationMachineApi::APITestException.new "Error: get all users"
    end

    user_response = user_management_controller.user_management_get_single_user(user_id);
    if (user_response["result"]["email"] != email)
        raise InformationMachineApi::APITestException.new "Error: get single user"
    end
end

def test_user_purchase products_controller, client_id, client_secret, store_id, username, password

    email = "testuser@iamdata.co";
    user_id = "testuserId1234";

    user_management_controller = InformationMachineApi::UserManagementController.new(client_id, client_secret);
    user_stores_controller = InformationMachineApi::UserStoresController.new(client_id, client_secret);
    user_purchases_controller = InformationMachineApi::UserPurchasesController.new(client_id, client_secret);
    user_scans_controller = InformationMachineApi::UserScansController.new(client_id, client_secret);

    user_management_controller_test(email, user_management_controller, user_id);

    logoSize = File.size?("encoded_logo.txt")
    logo = File.new("encoded_logo.txt","r")
    encoded_image = logo.sysread(logoSize);
    receipt_id = "fe6ba83b-d45c-457a-afd5-35bdb3cdffff";
    receipt_request = InformationMachineApi::UploadReceiptRequest.new()
    receipt_request.image = encoded_image
    receipt_request.receipt_id = receipt_id

    user_scans_controller.user_scans_upload_receipt(receipt_request.to_json, user_id);

    store_connect = InformationMachineApi::ConnectUserStoreRequest.new()
    store_connect.store_id = store_id
    store_connect.username = username
    store_connect.password = password

    user_store = user_stores_controller.user_stores_connect_store(store_connect.to_json, user_id)["result"];

    store_connection_valid = check_store_validity(user_stores_controller, user_id, user_store["id"]);
    if (!store_connection_valid)
        user_stores_controller.user_stores_delete_single_store(user_id, user_store["id"]);
        raise InformationMachineApi::APITestException.new "Error: could not connect to store"
    end

    update_user_store_request = InformationMachineApi::UpdateUserStoreRequest.new()
    update_user_store_request.username = username
    update_user_store_request.password = password

    user_stores_controller.user_stores_update_store_connection(update_user_store_request.to_json, user_id, user_store["id"]);

    if (!wait_for_scrape_to_finish(user_stores_controller, user_id, user_store["id"]))
        raise InformationMachineApi::APITestException.new "Error: scrape is not finished"
    end

    stores = user_stores_controller.user_stores_get_all_stores(user_id)["result"];
    if (stores.length == 0 or stores[0]["id"] <= 0)
        raise InformationMachineApi::APITestException.new "Error: could not get all stores"
    end

    user_products = products_controller.products_get_user_products(user_id, page:1, per_page:15, full_resp:true, food_only:true)["result"];
    if (user_products.length == 0)
        raise InformationMachineApi::APITestException.new "Error: get user products"
    end

    user_purchases = user_purchases_controller.user_purchases_get_all_user_purchases(user_id, page:1, per_page:15, full_resp:true)["result"];
    if (user_purchases.length == 0)
        raise InformationMachineApi::APITestException.new "Error: get all user purchases"
    end

    user_purchase = user_purchases_controller.user_purchases_get_single_user_purchase(user_id, user_purchases[0]["id"], full_resp:true)["result"];
    if (user_purchase == nil or user_purchase["id"] != user_purchases[0]["id"])
        raise InformationMachineApi::APITestException.new "Error: get single user purchases"
    end

    barcode_request = InformationMachineApi::UploadBarcodeRequest.new()
    barcode_request.bar_code = "021130126026"
    barcode_request.bar_code_type = "UPC-A"

    barcode_response = user_scans_controller.user_scans_upload_barcode(barcode_request.to_json, user_id)["result"];
    if (barcode_response["bar_code_type"] != "UPC-A" or barcode_response["bar_code"] != "021130126026")
        raise InformationMachineApi::APITestException.new "Error: upload barcode"
    end

    user_stores_controller.user_stores_delete_single_store(user_id, user_store["id"]);

    user_management_controller.user_management_delete_user(user_id);
end

def lookup_controller_test lookup_controller, store_name

    categories = lookup_controller.lookup_get_categories()["result"];
    if (categories.length == 0 or categories[0]["id"] != 1)
        raise InformationMachineApi::APITestException.new "Error: categories"
    end

    nutrients = lookup_controller.lookup_get_nutrients()["result"];
    if (nutrients.length == 0 or nutrients[0]["id"] != 7)
        raise InformationMachineApi::APITestException.new "Error: nutrients"
    end

    alternatives = lookup_controller.lookup_get_product_alternative_types()["result"];
    if (alternatives.length == 0 or alternatives[0]["id"] != 1 or alternatives[0]["name"] != "Reduce Sodium")
        raise InformationMachineApi::APITestException.new "Error: alternatives"
    end

    tags = lookup_controller.lookup_get_tags()["result"];
    if (tags.length == 0 or tags[0]["id"] != 29 or tags[0]["name"] != "Low Fat")
        raise InformationMachineApi::APITestException.new "Error: tags"
    end

    units_of_measurement = lookup_controller.lookup_get_uo_ms()["result"];
    if (units_of_measurement.length == 0 or units_of_measurement[0]["id"] != 1 or units_of_measurement[0]["name"] != "g")
        raise InformationMachineApi::APITestException.new "Error: units of measurements"
    end

    stores = lookup_controller.lookup_get_stores()["result"];
    if (stores.length == 0 or stores[0]["id"] != 1 or stores[0]["name"] != "FreshDirect")
        raise InformationMachineApi::APITestException.new "Error: stores"
    end

    stores.each do |store|
        if(store["name"] == store_name)
            return store["id"]
        end
    end
end

def products_controller_test products_controller

    kale_products = products_controller.products_search_products(name:"Kale", product_identifier:nil, page:1, per_page:25, request_data: nil, full_resp:true)["result"];
    if (kale_products.length == 0 or kale_products[0]["name"] == nil)
        raise InformationMachineApi::APITestException.new "Error: get products"
    end

    if (kale_products[0]["nutrients"][0]["name"].to_s == "")
        raise InformationMachineApi::APITestException.new "Error: get detail product info"
    end

    second_page_kale_products = products_controller.products_search_products(name:"Kale", product_identifier:nil, page:2, per_page:25, request_data: nil, full_resp:true)["result"];
    if (second_page_kale_products.length == 0 or second_page_kale_products[0]["name"] == nil or second_page_kale_products[0]["id"] == kale_products[0]["id"])
        raise InformationMachineApi::APITestException.new "Error: get 2nd page products"
    end

    upc_product = products_controller.products_search_products(name:nil, product_identifier:"014100044208", page:1, per_page:25, request_data: nil, full_resp:true)["result"];
    if (upc_product.length == 0 or upc_product[0]["name"] != "Pepperidge Farm Classic Bbq Cracker Chips, 6 Oz")
        raise InformationMachineApi::APITestException.new "Error: get upc products"
    end

    ean_product = products_controller.products_search_products(name:nil, product_identifier:"096619872404", page:nil, per_page:nil, request_data: nil, full_resp:true)["result"];
    if (ean_product.length == 0 or ean_product[0]["name"] != "Beckett Basketball Monthly Houston Rocket English")
        raise InformationMachineApi::APITestException.new "Error: get ean products"
    end

    product_full = products_controller.products_get_product("380728", full_resp:true)["result"];
    if (product_full == nil or product_full["name"] != "Peanut Butter Chocolate Party Size Candies")
        raise InformationMachineApi::APITestException.new "Error: get full product"
    end

    products_alternatives = products_controller.products_get_products_alternatives("120907, 120902", type_id:"7")["result"];
    if (products_alternatives.length == 0 or products_alternatives[0]["productAlternatives"][0]["name"] != "Lightlife Smart Deli Veggie Slices Roast Turkey")
        raise InformationMachineApi::APITestException.new "Error: get full product"
    end

    product_prices = products_controller.products_get_product_prices("149109, 113427")["result"];
    if (product_prices.length == 0 or product_prices[0]["prices"][0]["store_id"] != 4)
        raise InformationMachineApi::APITestException.new "Error: get full product"
    end
end

begin
    testData = IO.readlines("clienttest.txt")
    client_id = testData[0].chomp
    client_secret = testData[1].chomp
    store_name = testData[2].chomp
    username = testData[3].chomp
    password = testData[4].chomp
    
    Unirest.timeout(30)

    store_id = lookup_controller_test(InformationMachineApi::LookupController.new(client_id, client_secret), store_name);
    products_controller = InformationMachineApi::ProductsController.new(client_id, client_secret);

    products_controller_test(products_controller);

    test_user_purchase(products_controller, client_id, client_secret, store_id, username, password);
    
    puts "All tests passed"
rescue Exception => ex
    puts ex
    puts ex.backtrace
end
