# Análisis de Ventas — Global Superstore (2011-2014)

Proyecto de análisis de datos end-to-end (Python → SQL → Power BI) simulando el flujo de trabajo de un analista de datos junior en una empresa retail global.

## Contexto de negocio

Este proyecto simula el rol de analista de datos de una empresa retail con operaciones globales (Global Superstore), con el objetivo de responder preguntas clave para la gerencia comercial: ¿qué categorías de producto son más rentables?, ¿está creciendo el negocio de forma saludable?, ¿hay productos o mercados generando pérdidas que requieran atención?

## Stack técnico

- **Python (pandas):** limpieza, control de calidad y preparación de datos.
- **MySQL:** modelado relacional y consultas de negocio.
- **Power BI:** modelado DAX y visualización.

## Preguntas de negocio respondidas

1. ¿Qué categoría de producto vende más y cuál es más rentable?
2. ¿Existe relación entre el nivel de descuento y el margen de ganancia?
3. ¿El crecimiento en ventas viene de más clientes o de mayor gasto por cliente?
4. ¿Algún mercado o región genera pérdida neta agregada?
5. ¿Cuáles son los productos más y menos rentables del catálogo?

## Insights clave

- **Furniture vende bastante (2do lugar en ventas) pero es la categoría menos rentable** (6.94% de margen vs. 13-14% en las otras dos categorías), explicado por un descuento promedio significativamente más alto (16.81% vs. ~13.5% en el resto).
- **El crecimiento de ventas 2011-2014 (+90%) está impulsado por volumen de órdenes (+92%), no por incremento en el ticket promedio** — el negocio crece en base de clientes, no en gasto por cliente.
- **Ningún mercado geográfico (US, EU, APAC, LATAM, EMEA, Africa, Canadá) genera pérdida neta agregada**, aunque sí existen transacciones individuales con pérdida.
- **El 5º producto en el ranking de mayor ganancia (Zebra GK420t) presenta en realidad ganancia neta negativa** — evidencia de que varios productos del catálogo operan en pérdida y ameritan revisión de costos/descuentos.

## Problemas técnicos resueltos

Este dataset (51,290 filas) presentó varios desafíos reales de calidad de datos e integración de herramientas, documentados aquí como parte del proceso analítico:

- **Columnas de fecha corruptas:** `Order Date` y `Ship Date` llegaron con un único valor idéntico en el 100% de las filas (dato perdido en el origen). Se resolvió utilizando las columnas `Year` y `weeknum` como sustituto para el análisis temporal.
- **Codificación de caracteres:** el archivo requería `encoding='latin1'` en Python y ajustes de encoding en la importación a MySQL Workbench para evitar errores de caracteres especiales.
- **Desalineación de columnas en carga SQL:** `LOAD DATA INFILE` asigna por posición; fue necesario especificar explícitamente el orden real de columnas del CSV para evitar que los datos quedaran cruzados.
- **Bug de configuración regional en Power BI:** las columnas numéricas decimales (`Profit`, `Sales`, `Discount`, `Shipping Cost`) se interpretaron inicialmente con el separador de miles/decimales invertido (formato regional de Colombia vs. formato de origen del CSV), inflando `Ganancia Total` en varios órdenes de magnitud. Se corrigió especificando la configuración regional "Inglés (Estados Unidos)" al definir el tipo de dato.
- **Incompatibilidad de driver MySQL Connector/NET con Power BI:** ante un bug conocido del conector que impedía la conexión en vivo, se optó por alimentar Power BI desde el CSV limpio generado en Python (documentado como decisión de arquitectura, no como limitación oculta).

## Dashboard

El dashboard incluye:
- KPIs generales (Ventas Totales, Ganancia Total, Margen %).
- Ventas vs. Ganancia por Categoría.
- Distribución de Margen % por Categoría.
- Top 5 Productos por Ganancia (incluyendo el hallazgo de un producto en pérdida).
- Tendencia de Ventas y Ganancia 2011-2014.
- Ventas y Ganancia por Mercado global.

![Dashboard](dashboard_screenshot.png)

## Qué haría distinto con más tiempo

- Establecer conexión en vivo Power BI–MySQL (pendiente por incompatibilidad de driver, ver arriba) en lugar de un extracto estático.
- Investigar a nivel de transacción individual la causa raíz del descuento elevado en Furniture (¿política comercial, tipo de producto, canal de venta?).
- Incorporar un análisis de cohortes de clientes para profundizar en el hallazgo de crecimiento por volumen de órdenes.

## Archivos del proyecto

- `analisis_ventas.ipynb` — limpieza y EDA en Python.
- `consultas_ventas_semana1.sql` — consultas de negocio en MySQL.
- `dashboard_ventas_semana1.pbix` — dashboard interactivo en Power BI.
