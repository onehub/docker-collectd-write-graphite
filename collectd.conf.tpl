Hostname "{{ HOST_PREFIX }}-{{ HOSTNAME }}.{{ DOMAIN }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5

LoadPlugin cpu
LoadPlugin df
LoadPlugin load
LoadPlugin memory
LoadPlugin write_graphite
LoadPlugin write_riemann

<Plugin df>
  Device "{{ DISK_DEVICE | default("/dev/xvda9") }}"
  IgnoreSelected false
  ReportByDevice true
  ReportReserved true
  ReportInodes true
  ValuesPercentage true
</Plugin>

<Plugin "write_graphite">
 <Carbon>
   Host "{{ GRAPHITE_HOST }}"
   Port "{{ GRAPHITE_PORT | default("2003") }}"
   Protocol "tcp"
   Prefix "collectd."
   EscapeCharacter "_"
   SeparateInstances true
   StoreRates true
   AlwaysAppendDS false
 </Carbon>
</Plugin>

<Plugin "write_riemann">
  <Node "ops">
    Host "{{ RIEMANN_HOST }}"
    Port "{{ RIEMANN_PORT | default("5555") }}"
    Protocol UDP
    StoreRates true
    AlwaysAppendDS false
    TTLFactor 12
  </Node>
  Tag "collectd"
  Tag "{{ RIEMANN_ENV | default("unknown") }}"
</Plugin>
