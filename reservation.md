## 📜 VGPU 예약 설정/해제 스크립트 메뉴얼 (md)

# vgpu\_reserved\_control.sh 스크립트 메뉴얼

## 1\. 📋 개요

이 문서는 `set_3d_reserved.sh`와 `unset_3d_reserved.sh` 두 스크립트에 대해 설명합니다.

이 스크립트들은 OpenStack 환경에서 **미리 지정된 특정 VGPU 리소스 제공자(Provider)들의 예약(Reserved) 상태를 일괄적으로 변경**하기 위해 사용됩니다.

  * **`set_3d_reserved.sh`**: 스크립트 내에 하드코딩된 VGPU 리소스들의 `reserved` 값을 `1`로 설정합니다. (총량 `total=1` 포함)
  * **`unset_3d_reserved.sh`**: 동일한 VGPU 리소스들의 `reserved` 값을 `0`으로 설정합니다. (총량 `total=1` 포함)

`reserved=1`로 설정된 리소스는 OpenStack 스케줄러가 새 인스턴스(VM)에 할당하지 않으므로, 이 스크립트들은 특정 VGPU 리소스를 일시적으로 \*\*스케줄링에서 제외(Set)\*\*하거나 \*\*다시 포함(Unset)\*\*시키는 용도로 사용됩니다.

## 2\. ⚙️ 사전 요구사항

  * **OpenStack CLI (`python-openstackclient`):** `openstack` 명령어가 설치되어 있어야 합니다.
  * **인증 (Authentication):** 스크립트를 실행하는 환경에 OpenStack 인증 정보 (예: `openrc.sh` 파일)가 로드되어 있어야 합니다.
  * **필요 권한:** `openstack resource provider inventory set` 명령을 실행할 수 있는 충분한 권한 (보통 admin)이 필요합니다.

## 3\. 📜 스크립트 원본

### `set_3d_reserved.sh`

```bash
# 32개 VGPU 리소스의 'reserved' 값을 1로 설정합니다.
openstack resource provider inventory set --resource VGPU:reserved=1 --resource VGPU:total=1 ea9cebfc-5a74-478b-8216-8b18b288e8a3
openstack resource provider inventory set --resource VGPU:reserved=1 --resource VGPU:total=1 9b1e6e36-f639-40d8-b8ae-442dbee14b6a
# ... (이하 30개 UUID 동일) ...
openstack resource provider inventory set --resource VGPU:reserved=1 --resource VGPU:total=1 902b91b4-ac0d-4c58-9dbf-d80803062338
```

### `unset_3d_reserved.sh`

```bash
# 32개 VGPU 리소스의 'reserved' 값을 0으로 설정합니다.
openstack resource provider inventory set --resource VGPU:reserved=0 --resource VGPU:total=1 ea9cebfc-5a74-478b-8216-8b18b288e8a3
openstack resource provider inventory set --resource VGPU:reserved=0 --resource VGPU:total=1 9b1e6e36-f639-40d8-b8ae-442dbee14b6a
# ... (이하 30개 UUID 동일) ...
openstack resource provider inventory set --resource VGPU:reserved=0 --resource VGPU:total=1 902b91b4-ac0d-4c58-9dbf-d80803062338
```

## 4\. 🚀 사용 방법

1.  **파일 저장:** 위 내용을 각각의 `.sh` 파일로 저장합니다.

2.  **실행 권한 부여:**

    ```shell
    chmod +x set_3d_reserved.sh
    chmod +x unset_3d_reserved.sh
    ```

3.  **스크립트 실행:** (OpenStack 인증 정보가 로드된 터미널에서)

      * **VGPU 리소스를 예약 상태로 만들 때 (스케줄링에서 제외):**

        ```shell
        ./set_3d_reserved.sh
        ```

      * **VGPU 리소스를 예약 해제할 때 (다시 사용 가능하게 설정):**

        ```shell
        ./unset_3d_reserved.sh
        ```

## 5\. 🛠️ 주요 동작 설명

두 스크립트는 `openstack resource provider inventory set` 명령어를 사용합니다.

`openstack resource provider inventory set [옵션] <UUID>`

  * **`--resource VGPU:reserved=1`**:
      * `set_3d_reserved.sh`에서 사용됩니다.
      * VGPU 리소스 클래스의 `reserved`(예약됨) 수량을 `1`로 설정합니다.
  * **`--resource VGPU:reserved=0`**:
      * `unset_3d_reserved.sh`에서 사용됩니다.
      * VGPU 리소스 클래스의 `reserved`(예약됨) 수량을 `0`으로 설정합니다.
  * **`--resource VGPU:total=1`**:
      * 두 스크립트 공통입니다.
      * 해당 VGPU의 `total`(총량) 값이 `1`임을 보장합니다. (안정적인 재고 설정을 위해 `reserved` 값과 함께 명시)
  * **`<UUID>`** (예: `ea9cebfc-...`)\*\*:
      * 인벤토리(재고)를 수정할 대상 리소스 제공자(Provider)의 고유 UUID입니다.
      * 두 스크립트는 **동일한 32개**의 UUID 목록을 대상으로 작동합니다.

## 6\. ⚠️ 중요: 주의사항

  * **하드코딩된 UUID:** 이 스크립트들은 파일 내부에 **특정 UUID가 하드코딩**되어 있습니다. 이는 `vgpu_inventory.sh`처럼 동적으로 대상을 찾는 스크립트가 아닙니다.
  * **특정 환경 전용:** 스크립트에 명시된 32개의 UUID가 존재하는 특정 OpenStack 환경에서만 의미가 있습니다.
  * **관리자용:** 리소스의 재고(Inventory)를 직접 수정하는 것은 시스템 전체의 스케줄링에 영향을 미칩니다. 반드시 관리자 권한 및 책임 하에 사용해야 합니다.
