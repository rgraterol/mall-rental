admin_role = Role.create!(name: 'SUPER MALL ADMIN', permissions: Permission.where(name: 'manage'))


bs = Moneda.create!(nombre: 'Bolívares')
dolar = Moneda.create!(nombre: 'Dolares')
euro = Moneda.create!(nombre: 'Euros')

venezuela = Pai.create!(nombre: 'Venezuela', moneda: bs)
usa = Pai.create!(nombre: 'Estados Unidos', moneda: dolar)
españa = Pai.create!(nombre: 'España', moneda: euro)

cc_vela = Mall.create!(nombre: 'C.C La Vela', abreviado: 'cc_vela', rif: 'V-98735638-1', direccion_fiscal: 'Porlamar - Margarita', telefono: '0285-8965425', pai: venezuela)

User.create!(name: 'Icecream Father', username: 'mall_admin', password: '12345678', email: 'surf.airwaves@hotmail.com', cellphone: '0414-2312322', role: admin_role, mall: cc_vela)

ActividadEconomica.create!([{nombre: 'Zapateria', mall: cc_vela}, {nombre: 'Boutique', mall: cc_vela}, {nombre: 'Restaurant', mall: cc_vela}])
