require 'test_helper'

class PlantillaContratoAlquilersControllerTest < ActionController::TestCase
  setup do
    @plantilla_contrato_alquiler = plantilla_contrato_alquilers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plantilla_contrato_alquilers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plantilla_contrato_alquiler" do
    assert_difference('PlantillaContratoAlquiler.count') do
      post :create, plantilla_contrato_alquiler: { contenido: @plantilla_contrato_alquiler.contenido, nombre: @plantilla_contrato_alquiler.nombre }
    end

    assert_redirected_to plantilla_contrato_alquiler_path(assigns(:plantilla_contrato_alquiler))
  end

  test "should show plantilla_contrato_alquiler" do
    get :show, id: @plantilla_contrato_alquiler
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plantilla_contrato_alquiler
    assert_response :success
  end

  test "should update plantilla_contrato_alquiler" do
    patch :update, id: @plantilla_contrato_alquiler, plantilla_contrato_alquiler: { contenido: @plantilla_contrato_alquiler.contenido, nombre: @plantilla_contrato_alquiler.nombre }
    assert_redirected_to plantilla_contrato_alquiler_path(assigns(:plantilla_contrato_alquiler))
  end

  test "should destroy plantilla_contrato_alquiler" do
    assert_difference('PlantillaContratoAlquiler.count', -1) do
      delete :destroy, id: @plantilla_contrato_alquiler
    end

    assert_redirected_to plantilla_contrato_alquilers_path
  end
end
