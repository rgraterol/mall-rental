require 'test_helper'

class ClientesControllerTest < ActionController::TestCase
  setup do
    @cliente = clientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cliente" do
    assert_difference('Cliente.count') do
      post :create, cliente: { RIF: @cliente.RIF, cedula_contacto: @cliente.cedula_contacto, cedula_rl: @cliente.cedula_rl, direccion: @cliente.direccion, email_contacto: @cliente.email_contacto, email_rl: @cliente.email_rl, nombre: @cliente.nombre, nombre_contacto: @cliente.nombre_contacto, nombre_rl: @cliente.nombre_rl, profesion_contacto: @cliente.profesion_contacto, profesion_rl: @cliente.profesion_rl, telefono: @cliente.telefono, telefono_contacto: @cliente.telefono_contacto, telefono_rl: @cliente.telefono_rl }
    end

    assert_redirected_to cliente_path(assigns(:cliente))
  end

  test "should show cliente" do
    get :show, id: @cliente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cliente
    assert_response :success
  end

  test "should update cliente" do
    patch :update, id: @cliente, cliente: { RIF: @cliente.RIF, cedula_contacto: @cliente.cedula_contacto, cedula_rl: @cliente.cedula_rl, direccion: @cliente.direccion, email_contacto: @cliente.email_contacto, email_rl: @cliente.email_rl, nombre: @cliente.nombre, nombre_contacto: @cliente.nombre_contacto, nombre_rl: @cliente.nombre_rl, profesion_contacto: @cliente.profesion_contacto, profesion_rl: @cliente.profesion_rl, telefono: @cliente.telefono, telefono_contacto: @cliente.telefono_contacto, telefono_rl: @cliente.telefono_rl }
    assert_redirected_to cliente_path(assigns(:cliente))
  end

  test "should destroy cliente" do
    assert_difference('Cliente.count', -1) do
      delete :destroy, id: @cliente
    end

    assert_redirected_to clientes_path
  end
end
