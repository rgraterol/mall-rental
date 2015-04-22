admin_role = Role.create!(name: 'Super Usuario MallRental', permissions: Permission.where(name: 'manage'), role_type: Role.role_types[:administrador_sistema])
super_user_mall = Role.create!(name: 'Super Usuario Mall', permissions: Permission.where(name: 'manage', subject_class: ['mall_user']), role_type: Role.role_types[:administrador_cliente])
administrador_mall = Role.create!(name: 'Administrador Mall', permissions: Permission.where(name: 'manage', subject_class: ['ActividadEconomica', 'NivelMall', 'CalendarioNoLaborable', 'CambioMoneda', 'Local', 'Arrendatario', 'Tienda', 'ContratoAlquiler', 'UserTienda']), role_type: Role.role_types[:cliente_mall])
propietario_mall = Role.create!(name: 'Propietario Mall', role_type: Role.role_types[:cliente_mall])
gestor_alquileres = Role.create!(name: 'Gestor de Alquileres', role_type: Role.role_types[:cliente_mall])
gerente_tienda = Role.create!(name: 'Gerente de Tienda', role_type: Role.role_types[:cliente_tienda])
administrador_tienda = Role.create!(name: 'Administrador de Tienda', role_type: Role.role_types[:cliente_tienda])
propietario_tienda = Role.create!(name: 'Propietario de Tienda', role_type: Role.role_types[:cliente_tienda])
puts "#---- ROLES SEEDED -----#\n"