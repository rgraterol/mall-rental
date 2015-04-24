require 'test_helper'

class CuentaBancariaControllerTest < ActionController::TestCase
  setup do
    @cuenta_bancarium = cuenta_bancaria(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuenta_bancaria)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuenta_bancarium" do
    assert_difference('CuentaBancarium.count') do
      post :create, cuenta_bancarium: { beneficiario: @cuenta_bancarium.beneficiario, docIdentidad: @cuenta_bancarium.docIdentidad, nroCta: @cuenta_bancarium.nroCta, tipoCuenta: @cuenta_bancarium.tipoCuenta }
    end

    assert_redirected_to cuenta_bancarium_path(assigns(:cuenta_bancarium))
  end

  test "should show cuenta_bancarium" do
    get :show, id: @cuenta_bancarium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuenta_bancarium
    assert_response :success
  end

  test "should update cuenta_bancarium" do
    patch :update, id: @cuenta_bancarium, cuenta_bancarium: { beneficiario: @cuenta_bancarium.beneficiario, docIdentidad: @cuenta_bancarium.docIdentidad, nroCta: @cuenta_bancarium.nroCta, tipoCuenta: @cuenta_bancarium.tipoCuenta }
    assert_redirected_to cuenta_bancarium_path(assigns(:cuenta_bancarium))
  end

  test "should destroy cuenta_bancarium" do
    assert_difference('CuentaBancarium.count', -1) do
      delete :destroy, id: @cuenta_bancarium
    end

    assert_redirected_to cuenta_bancaria_path
  end
end
