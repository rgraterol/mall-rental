admin_role = Role.create!(name: 'SUPER MALL ADMIN', permissions: Permission.where(name: 'manage'))


bs = Moneda.create!(nombre: 'Bolívares')
dolar = Moneda.create!(nombre: 'Dolares')
euro = Moneda.create!(nombre: 'Euros')

venezuela = Pai.create!(nombre: 'Venezuela', moneda: bs)
usa = Pai.create!(nombre: 'Estados Unidos', moneda: dolar)
españa = Pai.create!(nombre: 'España', moneda: euro)

cc_vela = Mall.create!(nombre: 'C.C La Vela', abreviado: 'cc_vela', rif: 'V-98735638-1', direccion_fiscal: 'Porlamar - Margarita', telefono: '0285-8965425', pai: venezuela)

User.create!(name: 'Super Administrador', username: 'mall_admin', password: '12345678', email: 'surf.airwaves@hotmail.com', cellphone: '0414-2312322', role: admin_role, mall: cc_vela)

ActividadEconomica.create!([{nombre: 'Zapateria', mall: cc_vela}, {nombre: 'Boutique', mall: cc_vela}, {nombre: 'Restaurant', mall: cc_vela}])

comercial = TipoLocal.create!(tipo: 'Comercial')
empresarial =  TipoLocal.create!(tipo: 'Empresarial')

n_sotano = NivelMall.create!(nombre: 'Sotano')
n_uno = NivelMall.create!(nombre: 'Nivel Uno')
n_dos = NivelMall.create!(nombre: 'Nivel Dos')
n_tres = NivelMall.create!(nombre: 'Nivel Tres')

Local.create!([{nro_local: 'A-01', ubicacion_pasillo: 'A-01', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-02', ubicacion_pasillo: 'A-02', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-03', ubicacion_pasillo: 'A-03', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-04', ubicacion_pasillo: 'A-04', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-05', ubicacion_pasillo: 'A-05', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},])

NumerosControl.create!(nro_contrato: 1)
