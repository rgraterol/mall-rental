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

ActiveRecord::Schema.define(version: 20150405153456) do

  create_table "actividad_economicas", force: true do |t|
    t.string   "nombre"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actividad_economicas", ["mall_id"], name: "index_actividad_economicas_on_mall_id"

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

  create_table "idiomas", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inquilinos", force: true do |t|
    t.string   "nombre"
    t.string   "rif"
    t.string   "telefono"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.string   "representante_legal"
    t.string   "archivo_contrato"
    t.string   "tipo_canon_alquiler"
    t.integer  "local_id"
    t.integer  "actividad_economica_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inquilinos", ["actividad_economica_id"], name: "index_inquilinos_on_actividad_economica_id"
  add_index "inquilinos", ["local_id"], name: "index_inquilinos_on_local_id"

  create_table "locals", force: true do |t|
    t.string   "foto"
    t.string   "nro_local"
    t.string   "direccion"
    t.string   "ubicacion_pasillo"
    t.decimal  "area"
    t.boolean  "propiedad_mall"
    t.integer  "tipo_local_id"
    t.integer  "nivel_mall_id"
    t.integer  "mall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locals", ["mall_id"], name: "index_locals_on_mall_id"
  add_index "locals", ["nivel_mall_id"], name: "index_locals_on_nivel_mall_id"
  add_index "locals", ["tipo_local_id"], name: "index_locals_on_tipo_local_id"

  create_table "malls", force: true do |t|
    t.string   "nombre"
    t.string   "abreviado"
    t.string   "rif"
    t.string   "direccion_fiscal"
    t.string   "telefono"
    t.integer  "pai_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "malls", ["pai_id"], name: "index_malls_on_pai_id"

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

  add_index "nivel_malls", ["mall_id"], name: "index_nivel_malls_on_mall_id"

  create_table "pago_alquilers", force: true do |t|
    t.date     "fecha"
    t.string   "monto_canon_fijo_ml"
    t.string   "decimal"
    t.decimal  "monto_canon_fijo_usd"
    t.decimal  "monto_porc_ventas_ml"
    t.decimal  "monto_porc_ventas_usd"
    t.integer  "mes_alquiler"
    t.integer  "ano_alquiler"
    t.integer  "inquilino_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pago_alquilers", ["inquilino_id"], name: "index_pago_alquilers_on_inquilino_id"

  create_table "pais", force: true do |t|
    t.string   "nombre"
    t.integer  "idioma_id"
    t.integer  "moneda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pais", ["idioma_id"], name: "index_pais_on_idioma_id"
  add_index "pais", ["moneda_id"], name: "index_pais_on_moneda_id"

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

  add_index "permissions_roles", ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id"

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 50, default: "", null: false
    t.integer  "role_type",             default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

  create_table "ventas", force: true do |t|
    t.datetime "fecha"
    t.decimal  "monto_ml"
    t.decimal  "monto_usd"
    t.integer  "inquilino_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ventas", ["inquilino_id"], name: "index_ventas_on_inquilino_id"

end
