defmodule StipeWeb.Admin.OrganizationController do
  use StipeWeb, :controller

  alias Stipe.Company
  alias Stipe.Company.Organization
  alias Stipe.Accounts.User

  plug :authenticate

  def index(conn, _params) do
    organizations = Company.list_organizations()
    render(conn, "index.html", organizations: organizations)
  end

  def new(conn, _params) do
    changeset =
      Company.change_organization(%Organization{
        users: [
          %User{}
        ]
      })

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    case Company.create_organization(organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: Routes.organization_path(conn, :show, organization))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Company.get_organization!(id)

    render(conn, "show.html", organization: organization)
  end

  def edit(conn, %{"id" => id}) do
    organization = Company.get_organization!(id)
    changeset = Company.change_organization(organization)
    render(conn, "edit.html", organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Company.get_organization!(id)

    case Company.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: Routes.organization_path(conn, :show, organization))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Company.get_organization!(id)
    {:ok, _organization} = Company.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: Routes.organization_path(conn, :index))
  end

  defp authenticate(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:info, "Please enter your email address to continue.")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
