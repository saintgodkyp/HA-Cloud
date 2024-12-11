# HA-Cloud

본 Repository는 Openstack Cloud 구성 시, High Availability 서버 설정에 필요한 정보를 공유하기 위해 만들어졌습니다.

이 문서는 대학 교육 환경에서 안정적이고 고가용성을 갖춘 클라우드 인프라의 필요성을 강조하며, 이를 구현하기 위한 목표와 기술적 방안을 제시합니다. 상용 클라우드 서비스의 높은 비용을 대체하기 위해 DRBD, Pacemaker, OpenStack 등 오픈소스 기술을 활용하여 비용 효율적인 고가용성 인프라를 구축하고자 합니다.

주요 내용은 다음과 같습니다:

- **DRBD와 HAFS를 이용한 스토리지 미러링**: 각 노드의 NVMe 스토리지를 DRBD로 구성하여 실시간 데이터 복제를 수행하고, HAFS 파일 시스템을 통해 안정적인 데이터 저장을 지원합니다.

- **Pacemaker 기반 서비스 관리**: VIP와 주요 서비스를 Pacemaker로 관리하여 노드 간 자동 장애 복구를 구현하고, 서비스의 연속성을 보장합니다.

- **HAProxy로 부하 분산**: 주요 서비스를 HAProxy를 통해 라우팅하여 클러스터 내 부하를 분산시키고, Active-Active 및 Active-Standby 모드를 혼합 운영하여 가용성과 확장성을 높입니다.

- **VIP를 활용한 네트워크 구분**: 1G와 10G 네트워크를 역할에 따라 분리하고, VIP를 활용하여 내부 및 외부 트래픽을 적절히 분리하여 네트워크 효율성을 최적화합니다.

- **서비스 가용성 차등 적용**: 서비스 중요도에 따라 고가용성 전략을 차등 적용하여 운영 효율성을 극대화하고, 중요 서비스에는 DRBD와 Pacemaker를 적용하여 높은 안정성을 제공합니다.

- **비용 효율성 확보**: NVMe 스토리지와 오픈소스 기반 기술을 활용하여 데이터 복제와 저장 성능을 향상시키고, 자체 관리형 인프라로 운영비를 절감합니다.

전체적으로 이 문서는 교육 및 연구 환경에 최적화된 비용 효율적이고 고가용성을 갖춘 클라우드 인프라 구축 방안을 상세히 설명하고 있습니다.
This document emphasizes the need for stable and highly available cloud infrastructure in university education environments and outlines the objectives and technical strategies to achieve this. To replace the high costs associated with commercial cloud services, the goal is to build a cost-effective, high-availability infrastructure using open-source technologies such as DRBD, Pacemaker, and OpenStack.

**Key Points:**

- **Storage Mirroring with DRBD and HAFS:**
  - Real-time data replication is performed by configuring each node's NVMe storage with DRBD.
  - DRBD synchronizes I/O operations at the block device level, ensuring the file system is mounted only on the primary node.
  - HAFS file system is implemented on top of DRBD to support stable data storage.
  - Services like Glance image data and Apache2 configuration files are stored on HAFS, managed by Pacemaker to start only after HAFS is ready.

- **Service Management with Pacemaker:**
  - VIPs (Virtual IPs) and key services are managed using Pacemaker to automate failover between nodes.
  - Pacemaker continuously monitors service status and switches the primary node in case of anomalies, ensuring uninterrupted service access.
  - VIPs are alternately bound on each node to prevent service interruptions.

- **Load Balancing with HAProxy:**
  - Key services such as Nova, Glance, and Neutron are routed through HAProxy to distribute load within the cluster.
  - HAProxy operates bound to VIP-10G, routing service requests to each node and preventing traffic collisions between services.
  - Services operate in a mix of Active-Active and Active-Standby modes, with Pacemaker continuously managing service status.

- **Network Segmentation Using VIPs:**
  - The roles of the 1G and 10G networks are separated.
  - External-facing services like the Horizon dashboard are served over the 1G network.
  - Internal data-intensive services like Glance, Nova, and Neutron use the 10G network.
  - VIPs are utilized to appropriately separate internal and external traffic, preventing network collisions and optimizing bandwidth usage.

- **Differentiated Service Availability:**
  - Services are categorized based on importance, applying high-availability strategies accordingly.
  - Temporary educational and research services operate with basic availability settings.
  - Critical services requiring long-term operation utilize DRBD and Pacemaker for high stability.
  - For example, Glance and Keystone run only on one node based on HAFS and DRBD, supporting automatic failover via Pacemaker.

- **Optimized HA Configuration per Service:**
  - Services like Neutron and Nova operate in Active-Active mode to enhance availability and scalability.
  - Critical services use an Active-Standby approach to maintain data integrity and stable operation on a single node.

- **Cost Efficiency:**
  - NVMe storage configured with DRBD provides both data replication and storage performance.
  - Open-source technologies replace expensive commercial cloud storage solutions, increasing cost efficiency.
  - The OpenStack infrastructure leverages various services to provide functionality and availability comparable to commercial clouds while reducing operational costs through self-managed infrastructure.
  - Existing hardware is maximally utilized considering the characteristics of educational institutions, reducing new investment costs and ensuring maintainability and scalability.

**Summary:**

Overall, the document details a comprehensive plan to build a cost-effective, highly available cloud infrastructure optimized for educational and research environments. By leveraging open-source technologies and differentiating service availability based on importance, the strategy aims to provide stability, scalability, and operational efficiency while minimizing costs.
