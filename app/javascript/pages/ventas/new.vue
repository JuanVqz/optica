<template>
  <div id="venta-new">
    <form @submit.prevent="vender">
      <div class="row">
        <div class="col-md-3">
          <div class="form-group">
            <label for="fecha_entrega">
              Fecha entrega <span class="text-danger">*</span>
            </label>
            <input type="date" v-model="venta.fecha_entrega" id="fecha_entrega"
              class="form-control" :class="validar('fecha_entrega')"/>
            <div class="invalid-feedback">
              {{ mensajeDeError('fecha_entrega') }}
            </div>
          </div>
        </div>

        <div class="col-md-2">
          <div class="form-group" :class="validar('forma_de_pago')">
            <label for="forma_de_pago" class="form-control-label">
              Forma de pago <span class="text-danger">*</span>
            </label>
            <select v-model="venta.forma_de_pago" id="forma_de_pago"
              class="form-control">
              <option v-for="fp in formas_de_pago">{{ fp }}</option>
            </select>
            <div class="invalid-feedback">
              {{ mensajeDeError('forma_de_pago') }}
            </div>
          </div>
        </div>

        <div class="col-md-2">
          <div class="form-group row">
            <label class="col-12 text-center" for="facturar">¿desea facturar?</label>
            <label class="css-control css-control-primary css-radio col-12 text-center">
              <input type="checkbox" v-model="venta.facturar"
                id="facturar" class="css-control-input"/>
              <span class="css-control-indicator"></span>
              {{ facturarVenta }}
            </label>
          </div>
        </div>

        <div class="col-md-5">
          <div class="form-group" :class="validar('cliente')">
            <label for="buscar-clientes" class="form-control-label">
              Seleccionar cliente <span class="text-danger">*</span>
            </label>
            <select id="buscar-clientes" class="form-control"></select>
            <div class="invalid-feedback">
              {{ mensajeDeError('cliente') }}
            </div>
          </div>
        </div>

        <div class="col-md-2">
          <div class="form-group">
            <label for="descuento" class="form-control-label"> Descuento </label>
            <input type="text" :value="descuento | dinero" id="descuento"
              class="form-control" readonly/>
          </div>
        </div>

        <div class="col-md-2">
          <div class="form-group">
            <label for="total" class="form-control-label">
              Total <span class="text-danger">*</span>
            </label>
            <input type="text" :value="total | dinero"
              id="total" class="form-control"
              :class="validar('total')" readonly/>
            <div class="invalid-feedback">
              {{ mensajeDeError('total') }}
            </div>
          </div>
        </div>

        <div class="col-md-3">
          <div class="form-group">
            <label for="efectivo" class="form-control-label">
              Efectivo <span class="text-danger">*</span>
            </label>
            <input type="number" v-model="venta.pagos_attributes[0].efectivo"
              @change.prevent="calcularCambio" @keyup="calcularCambio"
              :class="validar(['pagos.efectivo'])" id="efectivo"
              class="form-control" step="any" required/>
            <div class="invalid-feedback">
              {{ mensajeDeError(['pagos.efectivo']) }}
            </div>
          </div>
        </div>

        <div class="col-md-3">
          <div class="form-group">
            <label for="anticipo" class="form-control-label">
              Anticipo <span class="text-danger">*</span>
            </label>
            <input type="number" v-model="venta.pagos_attributes[0].anticipo"
              @change.prevent="calcularCambio" @keyup="calcularCambio"
              :class="validar(['pagos.anticipo'])" id="anticipo"
              class="form-control" step="any" required />
              <div class="invalid-feedback">
                {{ mensajeDeError(['pagos.anticipo']) }}
              </div>
          </div>
        </div>

        <div class="col-md-2">
          <div class="form-group">
            <label for="cambio" class="form-control-label">
              Cambio <span class="text-danger">*</span>
            </label>
            <input type="number" v-model="venta.pagos_attributes[0].cambio"
              @change.prevent="calcularCambio" @keyup="calcularCambio"
              :class="validar(['pagos.cambio'])" id="cambio"
              class="form-control" min="0" readonly/>
              <div class="invalid-feedback">
                {{ mensajeDeError(['pagos.cambio']) }}
              </div>
          </div>
        </div>

        <div class="col-md-12">
          <div class="form-group">
            <label for="observaciones" class="form-control-label"> Observaciones </label>
            <textarea v-model="venta.observaciones" id="observaciones" class="form-control"></textarea>
          </div>
        </div>
      </div>

      <div v-if="ventaTieneProductos">
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-condensed table-hover">
                <thead>
                  <tr>
                    <th>código</th>
                    <th>cantidad</th>
                    <th>precio</th>
                    <th>descuento</th>
                    <th>subtotal</th>
                    <th>acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(vendido, index) in venta.vendidos_attributes" :key="vendido.id">
                    <td :title="`${vendido.nombre} | ${vendido.existencia} | ${vendido.tipo}`">
                      {{ vendido.codigo }}
                    </td>
                    <td>
                      <input type="number" v-model="vendido.cantidad"
                        @change.prevent="calcularSubtotal"
                        @keyup="calcularSubtotal"
                        class="form-control"
                        :class="validar(['vendidos.cantidad'])"/>
                      <div class="invalid-feedback">
                        {{ mensajeDeError(['vendidos.cantidad']) }}
                      </div>
                    </td>
                    <td class="text-right">
                      <input type="number" v-model="vendido.precio_venta"
                        @keyup="calcularSubtotal"
                        class="form-control" step="any"
                        :class="validar(['vendidos.precio_venta'])"/>
                      <div class="invalid-feedback">
                        {{ mensajeDeError(['vendidos.precio_venta']) }}
                      </div>
                    </td>
                    <td>
                      <input type="number" v-model="vendido.descuento"
                        @change.prevent="calcularSubtotal"
                        @keyup="calcularSubtotal"
                        class="form-control" step="any"/>
                    </td>
                    <td class="text-right">
                      <input type="text" :value="vendido.subtotal | dinero"
                        id="subtotal" class="form-control"
                        :class="validar(['vendidos.subtotal'])"
                        step="any" readonly/>
                      <div class="invalid-feedback">
                        {{ mensajeDeError(['vendidos.subtotal']) }}
                      </div>
                    </td>
                    <td class="text-center">
                      <div class="btn-group">
                        <button type="button" @click.prevent="eliminarProducto(index)"
                          class="btn btn-sm btn-danger">
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-10">
          <div class="form-group">
            <label for="buscar-productos">Seleccionar productos</label>
            <select id="buscar-productos" class="form-control"></select>
          </div>
        </div>

        <div class="col-md-2 align-self-center">
          <button type="submit" class="btn btn-alt-success">
            <i class="fa fa-save"></i>
            Cobrar
          </button>
        </div>
      </div>
    </form>

    <div class="modal fade" id="registrar-cliente" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="block block-themed block-transparent mb-0">
            <div class="block-header bg-primary-dark">
              <h3 class="block-title"><i class="fa fa-user"></i> Registrar cliente</h3>
              <div class="block-options">
                <button type="button" class="btn-block-option" data-dismiss="modal" aria-label="Close">
                  <i class="si si-close"></i>
                </button>
              </div>
            </div>
            <div class="block-content">
              <div class="row">

                <div class="col-md-6">
                  <div class="form-group">
                    <label for="cliente_nombre">
                      nombre <span class="text-danger">*</span>
                    </label>
                    <input type="text" v-model="cliente.nombre" id="cliente_nombre"
                      :class="validar('nombre')"
                      class="form-control"/>
                    <div class="invalid-feedback">{{ mensajeDeError('nombre') }}</div>
                  </div>
                </div>

                <div class="col-md-6">
                  <div class="form-group" :class="validar('corporacion_id')">
                    <label for="cliente_corporacion">
                      corporación <span class="text-danger">*</span>
                    </label>
                    <select v-model="cliente.corporacion_id" class="form-control"
                      id="cliente_corporacion">
                      <option v-for="c in corporaciones" :value="c.id" :key="c.id">
                        {{ c.nombre }}
                      </option>
                    </select>
                    <div class="invalid-feedback">
                      {{ mensajeDeError('corporacion_id') }}
                    </div>
                  </div>
                </div>

                <div class="col-md-6">
                  <div class="form-group">
                    <label for="cliente_telefono"> teléfono </label>
                    <input type="text" v-model="cliente.telefono"
                      id="cliente_telefono"
                      class="form-control" autocomplete="off"/>
                  </div>
                </div>

                <div class="col-md-6">
                  <div class="form-group">
                    <label for="cliente_rfc"> RFC </label>
                    <input type="text" v-model="cliente.rfc"
                      id="cliente_rfc"
                      class="form-control" autocomplete="off"/>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-9">
                  <div class="form-group">
                    <label for="cliente_calle"> calle </label>
                    <input type="text" v-model="cliente.domicilio_attributes.calle"
                      id="cliente_calle" class="form-control" />
                  </div>
                </div>

                <div class="col-md-3">
                  <div class="form-group">
                    <label for="cliente_numero"> número </label>
                    <input type="text" v-model="cliente.domicilio_attributes.numero"
                      id="cliente_numero" class="form-control" />
                  </div>
                </div>

                <div class="col-md-6">
                  <div class="form-group">
                    <label for="cliente_colonia"> colonia </label>
                    <input type="text" v-model="cliente.domicilio_attributes.colonia"
                      id="cliente_colonia" class="form-control" />
                  </div>
                </div>

                <div class="col-md-3">
                  <div class="form-group">
                    <label for="cliente_municipio"> municipio </label>
                    <input type="text" v-model="cliente.domicilio_attributes.municipio"
                      id="cliente_municipio" class="form-control" />
                  </div>
                </div>

                <div class="col-md-3">
                  <div class="form-group">
                    <label for="cliente_codigo_postal"> código postal </label>
                    <input type="text" v-model="cliente.domicilio_attributes.codigo_postal"
                      id="cliente_codigo_postal" class="form-control" />
                  </div>
                </div>

              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-alt-secondary" data-dismiss="modal">cerrar</button>
            <button type="button" @click.prevent="registrarCliente"
              class="btn btn-alt-primary">
              <i class="fa fa-save"></i> registrar
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: 'venta-new',

  data() {
    return {
      venta: {
        total: 0,
        descuento: 0,
        facturar: false,
        cliente_id: null,
        pagos_attributes: [
          { efectivo: 0, anticipo: 0, cambio: 0 }
        ],
        vendidos_attributes: [],
        forma_de_pago: ''
      },
      cliente: {
        domicilio_attributes: {}
      },
      formas_de_pago: [
        '01 - Efectivo',
        '02 - Cheque nominativo',
        '03 - Transferencia electrónica de fondos',
        '04 - Tarjeta de crédito',
        '28 - Tarjeta de débito'
      ],
      corporaciones: [],
      errores: {}
    }
  },

  mounted() {
    this.buscadorProductos()
    window.$('#buscar-productos').on('select2:select', (event) => {
      this.agregarProducto()
      this.limpiarBuscadorProductos()
      this.abrirBuscadorProductos()
      this.calcularSubtotal()
    })

    this.obtenerCorporaciones()
    this.buscadorClientes()
    window.$('#buscar-clientes').on('select2:select', (event) => {
      this.agregarCliente()
    })

    window.$('#registrar-cliente').on('shown.bs.modal', (e) => {
      this.cliente = {domicilio_attributes: {}}
      setTimeout(() => {
        window.$('#cliente_nombre').focus()
        window.$('#cliente_nombre').select()
      }, 1000)
      window.$('#buscar-clientes').select2('close')
    })
  },

  watch: {
    cliente() {
      this.venta.cliente_id = this.cliente.id
    }
  },

  computed: {
    ventaTieneProductos() {
      if (this.venta.vendidos_attributes.length) return true
      return false
    },

    total() {
      return this.venta.total = this.venta.vendidos_attributes
              .reduce((total, p) => total + p.subtotal, 0)
    },

    descuento() {
      return this.venta.descuento = this.venta.vendidos_attributes
              .reduce((descuento, p) => descuento + parseFloat(p.descuento), 0)
    },

    facturarVenta() {
      return this.venta.facturar ? 'SI' : 'NO'
    }
  },

  methods: {

    vender() {
      this.$http.post('/ventas', this.venta)
        .then(response => {
          window.$.notify({
           title: '<strong>Ventas</strong>',
           message: 'La venta fue creada correctamente.'
          })
          window.open(`${window.location.origin}/api/boletos/${response.data.data.id}/ventas`)
          setTimeout(() => window.location.href = response.data.data.url, 2000)
        })
        .catch(err => { this.errors = {}; this.errores = err.response.data })
    },

    calcularSubtotal() {
      this.venta.vendidos_attributes.map((p) => {
        p.subtotal = (p.cantidad * p.precio_venta) - p.descuento
      })
    },

    calcularCambio() {
      if (this.venta.pagos_attributes[0].efectivo) {
        this.venta.pagos_attributes[0].cambio = this.venta.pagos_attributes[0].efectivo - this.venta.pagos_attributes[0].anticipo
      }
    },

    abrirBuscadorProductos() {
      window.$('#buscar-productos').select2('open')
    },

    limpiarBuscadorProductos() {
      window.$("#buscar-productos").val(null).trigger("change")
    },

    agregarProducto() {
      let producto = JSON.parse(window.$('#buscar-productos').val())
      this.venta.vendidos_attributes.push(producto)
    },

    eliminarProducto(index) {
      this.venta.vendidos_attributes.splice(index, 1)
    },

    buscadorProductos() {
      window.$('#buscar-productos').select2({
        placeholder: 'Buscar productos',
        language: 'es',
        escapeMarkup: (markup) => { return markup },
        maximumSelectionLength: 1,
        allowClear: true,
        ajax: {
          url: `${window.location.origin}/api/productos`,
          dataType: 'json',
          delay: 250,
          data: (params) => { return { q: params.term } },
          processResults: (data, params) => {
            params.page = params.page || 1

            let items = data.items.map((item) => {
              return {
                id: JSON.stringify(item),
                text: `${item.codigo} | ${item.nombre} | $${item.precio_venta}`
              }
            })

            return {
              results: items,
              pagination: {
                more: (params.page * 10) < data.total_items
              }
            }
          }
        }
      })
    },

    obtenerCorporaciones() {
      this.$http.get('/api/corporaciones')
        .then(response => this.corporaciones = response.data.items)
        .catch(err => console.log(err))
    },

    buscadorClientes() {
      window.$('#buscar-clientes').select2({
        placeholder: 'Buscar cliente',
        language: {
          noResults() {
            return `<button type='button' data-toggle='modal' data-target='#registrar-cliente' class='btn btn-alt-danger'>
                      <i class='fa fa-plus'></i>
                      registrar cliente
                    </button>`
          }
        },
        escapeMarkup: (markup) => { return markup },
        maximumSelectionLength: 1,
        allowClear: true,
        ajax: {
          url: `${window.location.origin}/api/clientes`,
          dataType: 'json',
          delay: 250,
          data: (params) => { return { q: params.term } },
          processResults: (data, params) => {
            params.page = params.page || 1

            let items = data.items.map((item) => {
              let rfc = item.rfc ? `| ${item.rfc}` : ''

              return {
                id: JSON.stringify(item),
                text: `${item.nombre} | ${item.corporacion} ${rfc}`
              }
            })

            return {
              results: items,
              pagination: {
                more: (params.page * 10) < data.total_items
              }
            }
          }
        }
      })
    },

    agregarCliente() {
      this.cliente = JSON.parse(window.$('#buscar-clientes').val())
    },

    registrarCliente() {
      this.$http.post('/clientes', this.cliente)
        .then(response => {
          this.cliente = response.data
          window.$('#registrar-cliente').modal('hide')

          window.$.notify({
            title: `<strong>Cliente</strong>`,
            message: `El cliente ${this.cliente.nombre} fue creada correctamente.`
          })

          let opcion = `<option value="${this.cliente.id}" selected ="selected">${this.cliente.nombre}</option>`
          window.$('#buscar-clientes').html(opcion)
        })
        .catch(err => { this.errors = {}; this.errores = err.response.data })
    },

    validar(atributo) {
      return this.errores[atributo] ? 'is-invalid' : ''
    },

    mensajeDeError(atributo) {
      if ( ! this.errores[atributo] ) return false
      return this.errores[atributo][0]
    }

  }
}
</script>
