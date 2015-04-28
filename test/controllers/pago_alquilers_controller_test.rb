require 'test_helper'

class PagoAlquilersControllerTest < ActionController::TestCase
  setup do
    @pago_alquiler = pago_alquilers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pago_alquilers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pago_alquiler" do
    assert_difference('PagoAlquiler.count') do
      post :create, pago_alquiler: {  }
    end

    assert_redirected_to pago_alquiler_path(assigns(:pago_alquiler))
  end

  test "should show pago_alquiler" do
    get :show, id: @pago_alquiler
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pago_alquiler
    assert_response :success
  end

  test "should update pago_alquiler" do
    patch :update, id: @pago_alquiler, pago_alquiler: {  }
    assert_redirected_to pago_alquiler_path(assigns(:pago_alquiler))
  end

  test "should destroy pago_alquiler" do
    assert_difference('PagoAlquiler.count', -1) do
      delete :destroy, id: @pago_alquiler
    end

    assert_redirected_to pago_alquilers_path
  end
end
