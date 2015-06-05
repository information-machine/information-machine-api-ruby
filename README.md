Information Machine API
=================

How To Configure:
=================
File test\clienttest.txt contains several parameters in order to fully test the api using api_test.rb ruby file.
Each line of this file represents a certain expected value that you need to give in order to test the api.
The file initially contains the following:

1. YOUR_CLIENT_ID
2. YOUR_CLIENT_SECRET
3. STORE_NAME(EXAMPLE:WALMART)
4. USERNAME_FOR_GIVEN_STORE
5. PASSWORD_FOR_GIVEN_STORE

So, you need to replace the lines in clienttest.txt file with corresponding value.

How To Build:
=============
The generated code uses a Ruby gem namely 'unirest'. The reference to this gem is
already added in the gemspec. Therefore, you will need internet access to resolve
this dependency.

How To Use:
===========
The lib code can be used to build gem.
Otherwise, you can include the generated code in your project to use directly.

Use the following steps to build a gem and use locally

    1. Run the build command
        ```
        gem build information_machine_api.gemspec
        ```

    2. Run the install command
        ```
        gem install ./information_machine_api-1.0.gem
        ```

    3. In your Gemfile add this line
        ```
        gem 'information_machine_api', '~> 1.0'
        ```

    4. Now create an instance and use the instance methods, like following.

        ```
        products_controller = InformationMachineApi::ProductsController.new client_id, client_secret
        product_full = products_controller.products_get_product("380728", full_resp:true)["result"];
        ```
The quickest way to see how you should use the API and library itself is by opening test\api_test.rb ruby file and see for your self how to use the methods and what kind of flow for calling the api methods is expected.

All methods return wrapper object which contains meta information (number of available requests, maximum number of requests per minute) and result object. Additionally if the result is of an array type, meta object will contain paging information (current page, items per page, total number of items, url to next page if there is a next page).

For more information on which methods are available please go to [Information Machine](http://iamdata.co/swagger/ui/index)