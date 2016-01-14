# Class spacewalk::service
# ===========================
#
# Manage spacewalk service

class spacewalk::service (

  $service_ensure = $spacewalk::service_ensure,

){

  service {'spacewalk-service':
    ensure   => $service_ensure,
    start    => 'spacewalk-service start',
    stop     => 'spacewalk-service stop',
    restart  => 'spacewalk-service restart',
    status   => 'spacewalk-service status',
    provider => base,
  }
}
