require 'test_helper'

class PrecioServiciosControllerTest < ActionController::TestCase
  setup do
    @precio_servicio = precio_servicios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:precio_servicios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create precio_servicio" do
    assert_difference('PrecioServicio.count') do
      post :create, precio_servicio: { fecha: @precio_servicio.fecha, precio_usd: @precio_servicio.precio_usd }
    end

    assert_redirected_to precio_servicio_path(assigns(:precio_servicio))
  end

  test "should show precio_servicio" do
    get :show, id: @precio_servicio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @precio_servicio
    assert_response :success
  end

  test "should update precio_servicio" do
    patch :update, id: @precio_servicio, precio_servicio: { fecha: @precio_servicio.fecha, precio_usd: @precio_servicio.precio_usd }
    assert_redirected_to precio_servicio_path(assigns(:precio_servicio))
  end

  test "should destroy precio_servicio" do
    assert_difference('PrecioServicio.count', -1) do
      delete :destroy, id: @precio_servicio
    end

    assert_redirected_to precio_servicios_path
  end
end
