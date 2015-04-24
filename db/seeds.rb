<<<<<<< HEAD
=======

admin_role = Role.create!(name: 'SUPER MALL ADMIN', permissions: Permission.where(name: 'manage'))


>>>>>>> 7ca418d2c4173f77298279060393bd267e5c918b
bs = Moneda.create!(nombre: 'Bolívares')
dolar = Moneda.create!(nombre: 'Dolares')
euro = Moneda.create!(nombre: 'Euros')

CambioMoneda.create!(fecha: Date.today, cambio_ml_x_usd: 250)

venezuela = Pai.create!(nombre: 'Venezuela', moneda: bs)
usa = Pai.create!(nombre: 'Estados Unidos', moneda: dolar)
españa = Pai.create!(nombre: 'España', moneda: euro)

banco1 = Banco.create!(nombre: 'Banesco')

cuenta_banco1 = CuentaBancarium.create!(nroCta: '0134-5254-5485255', tipoCuenta: 'Corriente', beneficiario: 'Carlos Torres ', docIdentidad: "16417844", banco: banco1 )

cc_vela = Mall.create!(nombre: 'C.C La Vela', abreviado: 'cc_vela', rif: 'V-98735638-1', direccion_fiscal: 'Porlamar - Margarita', telefono: '0285-8965425', pai: venezuela, cuenta_bancarium: cuenta_banco1)



#ActividadEconomica.create!([{nombre: 'Zapateria', mall: cc_vela}, {nombre: 'Boutique', mall: cc_vela}, {nombre: 'Restaurant', mall: cc_vela}])

actividad_eco1 = ActividadEconomica.create!(nombre: 'Zapateria', mall: cc_vela)
actividad_eco2 = ActividadEconomica.create!(nombre: 'Boutique', mall: cc_vela)
actividad_eco3 = ActividadEconomica.create!(nombre: 'Restaurant', mall: cc_vela)

comercial = TipoLocal.create!(tipo: 'Comercial')
empresarial =  TipoLocal.create!(tipo: 'Empresarial')

n_sotano = NivelMall.create!(nombre: 'Sotano', mall: cc_vela)
n_uno = NivelMall.create!(nombre: 'Nivel Uno', mall: cc_vela)
n_dos = NivelMall.create!(nombre: 'Nivel Dos', mall: cc_vela)
n_tres = NivelMall.create!(nombre: 'Nivel Tres', mall: cc_vela)


Local.create!([{nro_local: 'A-01', ubicacion_pasillo: 'A-01', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-02', ubicacion_pasillo: 'A-02', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-03', ubicacion_pasillo: 'A-03', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-04', ubicacion_pasillo: 'A-04', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},
               {nro_local: 'A-05', ubicacion_pasillo: 'A-05', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno},])



local1 = Local.create!(nro_local: 'A-01', ubicacion_pasillo: 'A-01', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno)
local2 = Local.create!(nro_local: 'A-02', ubicacion_pasillo: 'A-02', area: 20, propiedad_mall: true, mall: cc_vela, tipo_local: comercial, nivel_mall: n_uno)
NumerosControl.create!(nro_contrato: 1)

arrendatario1 = Arrendatario.create!(nombre: 'Carlos Torres', rif: 'V-16351478-4', direccion:'Merida', telefono: '04161993398',
                                    nombre_rl: 'Juan Perez', cedula_rl: '123456', email_rl: 'carlos@gmail.com', telefono_rl: '65654',
                                    mall: cc_vela)

tienda1 = Tienda.create!(nombre: 'Lery Shop',fecha_apertura: '2015-01-10',fecha_fin_contrato_actual: '2015-10-01',
                         actividad_economica: actividad_eco1,local: local1, arrendatario: arrendatario1)

tipo_canon1 = TipoCanonAlquiler.create!(tipo: 'Canon fijo')

contrato_alquiler1 = ContratoAlquiler.create!(nro_contrato: '001', fecha_inicio: '2014-12-12', fecha_fin: '2015-12-12',
                                              estado_contrato: true, tipo_canon_alquiler: 1, archivo_contrato: 'archivo_c.pdf', tienda: tienda1)

ventas1 = Venta.create!(fecha: '2015-02-01',monto_ml: 1000, monto_usd: 10, tienda: tienda1)

<<<<<<< HEAD
# tipo_canon1 = TipoCanonAlquiler.create!(tipo: 'Canon fijo')
#
# contrato_alquiler1 = ContratoAlquiler.create!(nro_contrato: '001', fecha_inicio: '2014-12-12', fecha_fin: '2015-12-12',
#                                               estado_contrato: true, tipo_canon_alquiler: tipo_canon1, tienda: tienda1)
#
# ventas1 = Venta.create!(fecha: '2015-02-01',monto_ml: 1000, monto_usd: 10, tienda: tienda1)
puts "#--- DEVELOPMENT DATA SEEDED ----#"
=======
>>>>>>> 7ca418d2c4173f77298279060393bd267e5c918b
