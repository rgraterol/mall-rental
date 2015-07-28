require 'test_helper'

class VentaMensualsControllerTest < ActionController::TestCase
  setup do
    @venta_mensual = venta_mensuals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venta_mensual)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venta_mensual" do
    assert_difference('VentaMensual.count') do
      post :create, venta_mensual: { anio: @venta_mensual.anio, editable: @venta_mensual.editable, mes: @venta_mensual.mes, monto: @venta_mensual.monto, montoBruto: @venta_mensual.montoBruto, montoBrutoUSD: @venta_mensual.montoBrutoUSD, montoCostoVenta: @venta_mensual.montoCostoVenta, montoNeto: @venta_mensual.montoNeto, montoNetoUSD: @venta_mensual.montoNetoUSD, montoNotasCredito: @venta_mensual.montoNotasCredito }
    end

    assert_redirected_to venta_mensual_path(assigns(:venta_mensual))
  end

  test "should show venta_mensual" do
    get :show, id: @venta_mensual
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venta_mensual
    assert_response :success
  end

  test "should update venta_mensual" do
    patch :update, id: @venta_mensual, venta_mensual: { anio: @venta_mensual.anio, editable: @venta_mensual.editable, mes: @venta_mensual.mes, monto: @venta_mensual.monto, montoBruto: @venta_mensual.montoBruto, montoBrutoUSD: @venta_mensual.montoBrutoUSD, montoCostoVenta: @venta_mensual.montoCostoVenta, montoNeto: @venta_mensual.montoNeto, montoNetoUSD: @venta_mensual.montoNetoUSD, montoNotasCredito: @venta_mensual.montoNotasCredito }
    assert_redirected_to venta_mensual_path(assigns(:venta_mensual))
  end

  test "should destroy venta_mensual" do
    assert_difference('VentaMensual.count', -1) do
      delete :destroy, id: @venta_mensual
    end

    assert_redirected_to venta_mensuals_path
  end
end
