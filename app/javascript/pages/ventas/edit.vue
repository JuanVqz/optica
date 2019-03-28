<template>
  <div id="venta-edit">
    <div class="table-responsive">
      <table class="table table-hover table-sm table-vcenter">
        <thead>
          <tr>
            <th>Cliente</th>
            <th>Fecha compra</th>
            <th>Fecha entrega</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td v-if="venta.cliente">{{ venta.cliente.nombre }}</td>
            <td>{{ venta.created_at }}</td>
            <td>{{ venta.fecha_entrega }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="row">
      <div class="col-md-3">
        <div class="form-group">
          <label for="venta_descuento" class="form-control-label">
            Descuento
          </label>
          <input type="number" v-model="venta.descuento" id="venta_descuento"
            class="form-control" readonly/>
        </div>
      </div>

      <div class="col-md-3">
        <div class="form-group">
          <label for="venta_total" class="form-control-label">
            Total
          </label>
          <input type="text" v-model="venta.total" id="venta_total"
            class="form-control" readonly/>
        </div>
      </div>

      <div class="col-md-3">
        <div class="form-group">
          <label for="venta_anticipo" class="form-control-label">
            Anticipo
          </label>
          <input type="text" v-model="venta.anticipo" id="venta_anticipo"
            class="form-control" readonly/>
        </div>
      </div>

      <div class="col-md-3">
        <div class="form-group">
          <label for="venta_deuda" class="form-control-label">
            Deuda
          </label>
          <input type="text" v-model="venta.deuda" id="venta_deuda"
            class="form-control" readonly/>
        </div>
      </div>

      <div class="col-md-12 text-center">
        <cargando-component :cargando="cargando"/>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover table-sm table-vcenter text-center">
        <thead>
          <tr>
            <th colspan="2" class="text-center" v-if="venta.vendidos_attributes">
                productos vendidos ({{ venta.vendidos_attributes.length }})
            </th>
            <th colspan="5" class="text-right">
              <button type='button' data-toggle='modal' data-target='#agregar-pago' class='btn btn-alt-success'>
                <i class="fa fa-money"></i>
                agregar pago
              </button>
            </th>
          </tr>
          <tr>
            <th>código</th>
            <th>producto</th>
            <th>cantidad</th>
            <th>precio venta</th>
            <th>descuento</th>
            <th>subtotal</th>
            <th>acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(vendido, index) in venta.vendidos_attributes" :key="vendido.id"
              :class="marcarParaEliminar(vendido)">
            <td>{{ vendido.codigo }}</td>
            <td>{{ vendido.nombre }}</td>
            <td>{{ vendido.cantidad }}</td>
            <td class="text-right">{{ vendido.precio_venta | dinero }}</td>
            <td class="text-right">{{ vendido.descuento | dinero }}</td>
            <td class="text-right">{{ vendido.subtotal | dinero }}</td>
            <td>
              <button type="button" @click.prevent="sumarCantidad(index)"
                class="btn btn-sm btn-alt-success">
                <i class="fa fa-arrow-up"></i>
              </button>
              <button type="button" @click.prevent="restarCantidad(index)"
                class="btn btn-sm btn-alt-primary">
                <i class="fa fa-arrow-down"></i>
              </button>
              <button type="button" @click.prevent="eliminarProducto(index)"
                class="btn btn-sm btn-alt-danger">
                <i class="fa fa-times"></i>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="modal fade" id="agregar-pago" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="block block-themed block-transparent mb-0">
            <div class="block-header bg-primary-dark">
              <h3 class="block-title"><i class="fa fa-money"></i> Agregar pago</h3>
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
                    <label>deuda</label>
                    <input type="text" v-if="venta.pagos_attributes"
                      :value="this.venta.deuda | dinero"
                      class="form-control form-control-lg" disabled="disabled" />
                  </div>
                </div>

                <div class="col-md-6">
                  <div class="form-group">
                    <label>resto</label>
                    <input type="text" v-if="venta.pagos_attributes"
                      :value="resto | dinero"
                      class="form-control form-control-lg" disabled="disabled" />
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-group">
                    <label for="pago_efectivo">
                      efectivo <span class="text-danger">*</span>
                    </label>
                    <input type="number" v-if ="venta.pagos_attributes"
                      v-model="venta.pagos_attributes[0].efectivo"
                      @change.prevent="calcularCambio" @keyup="calcularCambio"
                      :class="errores['pagos.efectivo'] ? 'is-invalid' : ''"
                      id="pago_efectivo" class="form-control form-control-lg"/>
                    <div class="invalid-feedback" v-if="errores['pagos.efectivo']">
                      {{ errores['pagos.efectivo'][0] }}
                    </div>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-group">
                    <label for="pago_anticipo">
                      anticipo <span class="text-danger">*</span>
                    </label>
                    <input type="number" v-if ="venta.pagos_attributes"
                      v-model="venta.pagos_attributes[0].anticipo"
                      @change.prevent="calcularCambio" @keyup="calcularCambio"
                      :class="errores['pagos.anticipo'] ? 'is-invalid' : ''"
                      id="pago_anticipo" class="form-control form-control-lg"/>
                    <div class="invalid-feedback" v-if="errores['pagos.anticipo']">
                      {{ errores['pagos.anticipo'][0] }}
                    </div>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-group">
                    <label for="pago_cambio">
                      cambio <span class="text-danger">*</span>
                    </label>
                    <input type="number" v-if ="venta.pagos_attributes"
                      v-model="venta.pagos_attributes[0].cambio"
                      @change.prevent="calcularCambio" @keyup="calcularCambio"
                      :class="errores['pagos.cambio'] ? 'is-invalid' : ''"
                      id="pago_cambio" min="0" class="form-control form-control-lg"
                      readonly="readonly"/>
                    <div class="invalid-feedback" v-if="errores['pagos.cambio']">
                      {{ errores['pagos.cambio'][0] }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-alt-secondary" data-dismiss="modal">cerrar</button>
            <button type="button" @click.prevent="agregarPago"
              class="btn btn-alt-primary">
              <i class="fa fa-save"></i> Cobrar
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: 'venta-edit',

  data() {
    return {
      venta: {},
      cargando: false,
      errores: {}
    }
  },

  mounted() {
    this.obtenerVenta()

    window.$('#agregar-pago').on('shown.bs.modal', (e) => {
      setTimeout(() => {
        window.$('#pago_efectivo').focus()
        window.$('#pago_efectivo').select()
      }, 1000)
    })
  },

  computed: {
    resto() {
      return this.venta.deuda - this.venta.pagos_attributes[0].anticipo
    }
  },

  methods: {
    agregarPago() {
      this.$http.patch(`/ventas/${this.venta.id}.json`, this.venta)
        .then(response => {
          window.$('#agregar-pago').modal('hide')

          window.$.notify({
            title: '<strong>Ventas</strong>',
            message: 'La venta fue actualizada correctamente.',
            type: 'warning',
          })
          window.open(`${window.location.origin}/api/boletos/${response.data.data.id}/ventas`)
          setTimeout(() => window.location.href = response.data.data.url, 2000)
        })
        .catch(err => { this.errores = {}; this.errores = err.response.data })
    },

    calcularCambio() {
      if (this.venta.pagos_attributes[0].efectivo) {
        this.venta.pagos_attributes[0].cambio = this.venta.pagos_attributes[0].efectivo - this.venta.pagos_attributes[0].anticipo
      }
    },

    calcularTotal() {
      this.venta.descuento = this.venta.vendidos_attributes
        .filter(({_destroy}) => _destroy == false)
        .reduce((descuento, p) => descuento + parseFloat(p.descuento), 0)

      this.venta.total = this.venta.vendidos_attributes
        .filter(({_destroy}) => _destroy == false)
        .reduce((total, p) => total + parseFloat(p.subtotal), 0)

      this.venta.deuda = this.venta.total - this.venta.anticipo
    },

    sumarCantidad(index) {
      let v = this.venta.vendidos_attributes[index]
      v.cantidad += 1
      v.subtotal = (v.cantidad * v.precio_venta) - v.descuento
      this.calcularTotal()
    },

    restarCantidad(index) {
      let v = this.venta.vendidos_attributes[index]
      if (v.cantidad > 1) {
        v.cantidad -= 1
        v.subtotal = (v.cantidad * v.precio_venta) - v.descuento
        this.calcularTotal()
      }
    },

    eliminarProducto(index) {
      let v = this.venta.vendidos_attributes[index]
      v._destroy = ! v._destroy
      this.calcularTotal()
    },

    obtenerVenta() {
      let id = parseInt(window.location.href.split('/')[4])

      this.cargando = true
      this.$http.get(`/api/ventas/${id}`)
        .then(response => {
          this.venta    = response.data
          this.cargando = false
        })
        .catch(err => console.log(err))
    },

    marcarParaEliminar(vendido) {
      return vendido._destroy ? 'table-danger' : ''
    }
  }
}
</script>
