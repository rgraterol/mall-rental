# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150423022159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actividad_economicas", force: true do |t|
    t.string   "nombre"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actividad_economicas", ["mall_id"], name: "index_actividad_economicas_on_mall_id", using: :btree

  create_table "arrendatarios", force: true do |t|
    t.string   "nombre"
    t.string   "rif"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "nombre_rl"
    t.string   "cedula_rl"
    t.string   "email_rl"
    t.string   "telefono_rl"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arrendatarios", ["mall_id"], name: "index_arrendatarios_on_mall_id", using: :btree

  create_table "bancos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calendario_no_laborables", force: true do |t|
    t.date     "fecha"
    t.string   "motivo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cambio_monedas", force: true do |t|
    t.date     "fecha"
    t.decimal  "cambio_ml_x_usd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canon_alquilers", force: true do |t|
    t.date     "fecha"
    t.decimal  "canon_fijo_ml"
    t.decimal  "canon_fijo_usd"
    t.decimal  "porc_canon_ventas"
    t.integer  "monto_minimo_ventas"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contrato_alquilers", force: true do |t|
    t.string   "nro_contrato"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.string   "archivo_contrato"
    t.decimal  "canon_fijo_ml"
    t.decimal  "canon_fijo_usd"
    t.decimal  "porc_canon_ventas"
    t.decimal  "monto_minimo_ventas"
    t.boolean  "estado_contrato"
    t.integer  "tipo_canon_alquiler"
    t.integer  "tienda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contrato_alquilers", ["tienda_id"], name: "index_contrato_alquilers_on_tienda_id", using: :btree

  create_table "cuenta_bancaria", force: true do |t|
    t.string   "nroCta"
    t.string   "tipoCuenta"
    t.string   "beneficiario"
    t.string   "docIdentidad"
    t.integer  "banco_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cuenta_bancaria", ["banco_id"], name: "index_cuenta_bancaria_on_banco_id", using: :btree

  create_table "idiomas", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locals", force: true do |t|
    t.string   "foto"
    t.string   "nro_local"
    t.string   "ubicacion_pasillo"
    t.decimal  "area"
    t.boolean  "propiedad_mall"
    t.integer  "tipo_local_id"
    t.integer  "nivel_mall_id"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locals", ["mall_id"], name: "index_locals_on_mall_id", using: :btree
  add_index "locals", ["nivel_mall_id"], name: "index_locals_on_nivel_mall_id", using: :btree
  add_index "locals", ["tipo_local_id"], name: "index_locals_on_tipo_local_id", using: :btree

  create_table "malls", force: true do |t|
    t.string   "nombre"
    t.string   "abreviado"
    t.string   "rif"
    t.string   "direccion_fiscal"
    t.string   "telefono"
    t.integer  "pai_id"
    t.integer  "cuenta_bancarium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "malls", ["cuenta_bancarium_id"], name: "index_malls_on_cuenta_bancarium_id", using: :btree
  add_index "malls", ["pai_id"], name: "index_malls_on_pai_id", using: :btree

  create_table "monedas", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nivel_malls", force: true do |t|
    t.string   "nombre"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nivel_malls", ["mall_id"], name: "index_nivel_malls_on_mall_id", using: :btree

  create_table "numeros_controls", force: true do |t|
    t.integer  "nro_contrato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pago_alquilers", force: true do |t|
    t.string   "nro_recibo"
    t.date     "fecha_recibo_cobro"
    t.integer  "anio_alquiler"
    t.integer  "mes_alquiler"
    t.decimal  "monto_canon_fijo_ml"
    t.decimal  "monto_porc_ventas_ml"
    t.decimal  "monto_alquiler_ml"
    t.decimal  "monto_alquiler_usd"
    t.boolean  "pagado"
    t.date     "fecha_pago"
    t.string   "nro_cheque_confirmacion"
    t.string   "archivo_transferencia"
    t.string   "nombre_banco"
    t.boolean  "facturado"
    t.string   "nro_factura"
    t.date     "fecha_factura"
    t.integer  "tipo_pago"
    t.integer  "contrato_alquiler_id"
    t.integer  "tienda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pago_alquilers", ["contrato_alquiler_id"], name: "index_pago_alquilers_on_contrato_alquiler_id", using: :btree
  add_index "pago_alquilers", ["tienda_id"], name: "index_pago_alquilers_on_tienda_id", using: :btree

  create_table "pais", force: true do |t|
    t.string   "nombre"
    t.integer  "idioma_id"
    t.integer  "moneda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pais", ["idioma_id"], name: "index_pais_on_idioma_id", using: :btree
  add_index "pais", ["moneda_id"], name: "index_pais_on_moneda_id", using: :btree

  create_table "permissions", force: true do |t|
    t.string   "subject_class", limit: 60, default: ""
    t.string   "action",        limit: 50, default: "", null: false
    t.string   "name",          limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  add_index "permissions_roles", ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 50, default: "", null: false
    t.integer  "role_type",             default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiendas", force: true do |t|
    t.string   "nombre"
    t.date     "fecha_apertura"
    t.date     "fecha_cierre"
    t.boolean  "abierta"
    t.date     "fecha_fin_contrato_actual"
    t.integer  "local_id"
    t.integer  "actividad_economica_id"
    t.integer  "arrendatario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tiendas", ["actividad_economica_id"], name: "index_tiendas_on_actividad_economica_id", using: :btree
  add_index "tiendas", ["arrendatario_id"], name: "index_tiendas_on_arrendatario_id", using: :btree
  add_index "tiendas", ["local_id"], name: "index_tiendas_on_local_id", using: :btree

  create_table "tipo_canon_alquilers", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_locals", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tiendas", force: true do |t|
    t.integer  "user_id"
    t.integer  "tienda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tiendas", ["tienda_id"], name: "index_user_tiendas_on_tienda_id", using: :btree
  add_index "user_tiendas", ["user_id"], name: "index_user_tiendas_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                          default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "email",                             default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "unique_session_id",      limit: 20
    t.string   "name"
    t.string   "cellphone"
    t.string   "avatar"
    t.integer  "mall_id"
    t.boolean  "locked",                            default: false
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "ventas", force: true do |t|
    t.datetime "fecha"
    t.decimal  "monto_ml",   precision: 8, scale: 2
    t.decimal  "monto_usd",  precision: 8, scale: 2
    t.integer  "tienda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "editable",                           default: true
  end

  add_index "ventas", ["tienda_id"], name: "index_ventas_on_tienda_id", using: :btree

end
