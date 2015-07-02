require 'test_helper'

class VentaDiariaControllerTest < ActionController::TestCase
  setup do
    @venta_diarium = venta_diaria(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venta_diaria)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venta_diarium" do
    assert_difference('VentaDiarium.count') do
      post :create, venta_diarium: { editable: @venta_diarium.editable, fecha: @venta_diarium.fecha, monto: @venta_diarium.monto, monto_bruto: @venta_diarium.monto_bruto, monto_bruto_usd: @venta_diarium.monto_bruto_usd, monto_costo_venta: @venta_diarium.monto_costo_venta, monto_neto: @venta_diarium.monto_neto, monto_neto_usd: @venta_diarium.monto_neto_usd, monto_notas_credito: @venta_diarium.monto_notas_credito }
    end

    assert_redirected_to venta_diarium_path(assigns(:venta_diarium))
  end

  test "should show venta_diarium" do
    get :show, id: @venta_diarium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venta_diarium
    assert_response :success
  end

  test "should update venta_diarium" do
    patch :update, id: @venta_diarium, venta_diarium: { editable: @venta_diarium.editable, fecha: @venta_diarium.fecha, monto: @venta_diarium.monto, monto_bruto: @venta_diarium.monto_bruto, monto_bruto_usd: @venta_diarium.monto_bruto_usd, monto_costo_venta: @venta_diarium.monto_costo_venta, monto_neto: @venta_diarium.monto_neto, monto_neto_usd: @venta_diarium.monto_neto_usd, monto_notas_credito: @venta_diarium.monto_notas_credito }
    assert_redirected_to venta_diarium_path(assigns(:venta_diarium))
  end

  test "should destroy venta_diarium" do
    assert_difference('VentaDiarium.count', -1) do
      delete :destroy, id: @venta_diarium
    end

    assert_redirected_to venta_diaria_path
  end
end
