require 'test_helper'

class DocumentoVentasControllerTest < ActionController::TestCase
  setup do
    @documento_venta = documento_ventas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documento_ventas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documento_venta" do
    assert_difference('DocumentoVenta.count') do
      post :create, documento_venta: { nomnbre: @documento_venta.nomnbre, titulo: @documento_venta.titulo }
    end

    assert_redirected_to documento_venta_path(assigns(:documento_venta))
  end

  test "should show documento_venta" do
    get :show, id: @documento_venta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @documento_venta
    assert_response :success
  end

  test "should update documento_venta" do
    patch :update, id: @documento_venta, documento_venta: { nomnbre: @documento_venta.nomnbre, titulo: @documento_venta.titulo }
    assert_redirected_to documento_venta_path(assigns(:documento_venta))
  end

  test "should destroy documento_venta" do
    assert_difference('DocumentoVenta.count', -1) do
      delete :destroy, id: @documento_venta
    end

    assert_redirected_to documento_ventas_path
  end
end
